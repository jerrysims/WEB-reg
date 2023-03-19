class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_for_locked_parent
  before_action :set_current_student, only: [:choose_class, :drop_class, :index]
  before_action :set_course_and_tuition, only: [:index]
  before_action :set_total_fees_and_tuition, only: [:finalize, :review, :stripe_return]
  before_action :reg_fees_paid, only: [:stripe_return]

  def add_to_wait_list
    WaitListedStudent.create(wait_list_student_params)

    head :no_content
  end

  def choose_class
    @student = Student.find(params[:student_id])
    @section = Section.find(params[:section_id])
    @registration = Registration.new(student_id: @student.id, section_id: @section.id,
      status: :pending, user: current_parent)
    if @registration.save
      @registered = true
      set_course_and_tuition
    else
      @registered = false
      @class_is_full = @registration.section.at_max?
      @error_content = @registration.errors.full_messages.first
    end
  end

  def complete_parent_info
    @student_id = params[:student_id]
  end

  def create_checkout_session
    unless line_items_for_checkout.empty?
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: line_items_for_checkout,
        mode: 'payment',
        discounts: current_parent.students.count <= 1 ? nil : sibling_discount,
        success_url:  stripe_return_url(parent_id: current_parent.id),
        cancel_url: registrations_finalize_url(failed: true),
        customer_email: current_parent.email,
        client_reference_id: current_parent.id,
        metadata: {
          parent_id: current_parent.id
        }
      })

      render json: session
    else
      flash[:notice] = "Registration & Admin Fees already paid"
      redirect_to root_url
    end
  end

  def drop_class
    @section = Section.find(params[:section_id])
    r = Registration.where(["student_id = ? and section_id = ?", params[:student_id], params[:section_id]]).first
    if r
      r.destroy
      @dropped = true
      set_course_and_tuition
    else
      @dropped = false
    end
  end

  def finalize
    @administrative_fee = fee_paid?(Product::ADMINISTRATIVE_FEE) ? 0 : Invoice.administrative_fee
    @enrolled_students = current_parent.students.enrolled
    @discount = current_parent.enrolled_students_count > 1 && discount_not_yet_applied? ? Invoice.discount : nil
    
    @fees = []
    @fees << ["Administrative Fee", @administrative_fee]

    @enrolled_students.each do |s|
      unless fee_paid?(s.reg_fee, s.id)
        @fees << ["#{s.full_name} Registration Fee", '%.2f' % s.reg_fee.unit_price]
      end
    end

    @fees << ["Family Discount (multiple enrollees)", @discount] unless @discount.nil?
    @invoice_total = @fees.inject(0){ |sum, e| sum + e.last } 
    @api_key = ENV["RAILS_ENV"] == "production" ? "pk_live_51H2jFbGTkur4XSpD7Plmk3JYzi0WmIV4fvaCxgySaZvffKKx3kWJNNtdJE0QbES4kvPHcdf671NjoEIXzpS7NZ6C00H9dC0jiA" : "pk_test_51H2jFbGTkur4XSpD5pU3zfSSgPtwzYTcH6MaAEYEvsudqq2pT0agYCetpiZwtkMhZwx1STYuwyTpAgimF1TvoWhC00sor13DiZ"
  end

  def index
    redirect_to(
      action: "complete_parent_info",
      student_id: params[:student_id]
      ) unless current_parent.valid?(:course_registration)

    @browser = browser.name
    @student = Student.find(params[:student_id])
    @closed = current_parent.invoice_closed?

    @available_sections = available_sections(@student)
    day_order = %w(Tuesday Thursday Tuesday/Thursday)
    @days = @available_sections.map { |c| c.day }.uniq.sort_by { |c| day_order.index(c) }
    @start_times = @available_sections.map { |c| c.start_time }.uniq.sort
    @tuesday_courses = []
    @thursday_courses = []

    @available_sections.map do |c|
      case c.day
      when "Tuesday"
        @tuesday_courses << c
      when "Thursday"
        @thursday_courses << c
      when "Tuesday/Thursday"
        @tuesday_courses << c
        @thursday_courses << c
      end
    end
  end

  def review
    @enrolled_students = current_parent.students.enrolled
    @not_enrolled = current_parent.students - @enrolled_students
  end

  def stripe_return
    # @semester, @monthly = Invoice.tuition_totals(current_parent)
    # @payment_preference_section = payment_preference_section
    # @donation = Invoice.get_donation(current_parent) || InvoiceLineItem.new
    # @checked = get_donation_radio_check(@donation.quantity)
  end

  def update_parent
    current_parent.update_attributes(parent_params)

    if current_parent.valid?(:course_registration)
      # TODO: I must figure out how to get the student's information to this point
      redirect_to(action: "index", student_id: params[:student_id])
    else
      redirect_back fallback_location: {
        action: "complete_parent_info", student_id: params[:student_id]
      }
    end 
  end

  def update_tuition_preference
    current_parent.update_attributes(parent_params)
    @donation_total = params[:parent][:donation][:quantity]
    create_donation(@donation_total)

    redirect_to invoices_path
  end

  private

  def available_sections(student)
    Section.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def create_donation(donation_total)
    @invoice = Invoice.find_or_create_by(parent: current_parent)
    if @donation = Invoice.get_donation(current_parent)
      @donation.update_attributes(quantity: donation_total)
    else
      @donation = InvoiceLineItem.create(
        invoice: @invoice,
        product: Product::DONATION,
        quantity: donation_total,
        parent: current_parent
      )
    end
  end

  def discount_not_yet_applied?
    !InvoiceLineItem.find_by(parent: current_parent, product: Product::SIBLING_DISCOUNT)
  end

  def donation_total
    params.require(:parent).require(:donation).permit(:quantity)
  end

  def fee_paid?(product, student_id=nil)
    InvoiceLineItem.find_by(parent: current_parent, product: product, student_id: student_id)
  end

  def get_donation_radio_check(amount)
    [0,10,25,50].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def get_program_donation_radio_check(amount)
    [0,75,100,150].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def line_items_for_checkout
    items = []

    current_parent.registered_students.each do |s|
      unless InvoiceLineItem.find_by(parent: current_parent, student_id: s.id)
        items << {
          name: "Registration Fee - #{s.full_name}",
          amount: s.reg_fee.unit_price * 100,
          quantity: 1,
          currency: "usd",
        }
      end
    end

    unless InvoiceLineItem.find_by(parent: current_parent, product: Product::ADMINISTRATIVE_FEE)
      items << {
        name: "Administrative Fee - #{current_parent.full_name}",
        amount: Product::ADMINISTRATIVE_FEE.unit_price * 100,
        quantity: 1,
        currency: "usd"
      }
    end

    items
  end

  def parent_tuition_total
  end

  def payment_preference_section
    current_parent.tuition_preference && current_parent.payment_preference ? "preference" : "no_preference"
  end

  def reg_fees_paid
    admin_fee = Product::ADMINISTRATIVE_FEE
    
    ActiveRecord::Base.transaction do 
      i = Invoice.find_or_create_by(parent: current_parent)
      
      InvoiceLineItem.find_or_create_by(invoice: i, parent: current_parent, product: admin_fee, quantity: 1)
      current_parent.registered_students.each do |s|
        InvoiceLineItem.find_or_create_by(invoice: i, parent: current_parent, student_id: s.id, product: s.reg_fee, quantity: 1)
      end
      unless current_parent.students.count <= 1 || InvoiceLineItem.find_by(parent: current_parent, product: Product::SIBLING_DISCOUNT)
        InvoiceLineItem.create(invoice: i, parent: current_parent, product: Product::SIBLING_DISCOUNT, quantity: 1)
      end
    end 
  end

  def set_course_and_tuition
    @course_fees = @current_student.courses.inject(0){ |sum,e| sum + e.fee }
    @student_tuition_total = @current_student.courses.inject(0){ |sum, e| sum + e.semester_tuition }
  end

  def set_current_student
    @current_student = Student.find(params[:student_id])
  end

  def set_total_fees_and_tuition
    @parent_tuition_total = current_parent.courses.inject(0){ |sum, e| sum + e.semester_tuition }
    @parent_total_course_fees = current_parent.courses.inject(0){ |sum, e| sum + e.fee }
  end


  def sibling_discount
    return if current_parent.students.count <= 1 || InvoiceLineItem.find_by(parent: current_parent, product: Product::SIBLING_DISCOUNT)

    [{
      coupon: Stripe::Coupon.create(
        amount_off: 5000,
        duration: "once",
        currency: "usd"
      )
    }]
  end

  def total_fees
    student_count = current_parent.registered_students.count
    total_fees = ((Invoice.registration_fee * student_count) +
                 Invoice.administrative_fee + (student_count > 1 ? Invoice.discount : 0))

    total_fees
  end

  def tuition_total
    case current_parent.tuition_preference
      when "Semester"
        @semester
      when "Monthly"
        @monthly
      else
        @semester
    end
  end

  def parent_params
    params.require(:parent).permit(:id, :first_name, :last_name, :email, :phone_number,
      :secondary_email, :street_address_1, :street_address_2, :city, :state, :zip_code,
      :tuition_preference, :payment_preference)
  end

  def wait_list_student_params
    params.permit(:section_id, :student_id)
  end

end
