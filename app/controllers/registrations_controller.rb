class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_for_locked_parent, except: [:new, :select_student, :create, :course_options]
  before_action :set_current_student, only: [:choose_class, :drop_class, :index]
  before_action :set_rp
  before_action -> { set_course_and_tuition(@rp) }, only: [:index, :review]

  before_action -> { set_total_fees_and_tuition(@rp) }, only: [:finalize, :review, :stripe_return]
  before_action :reg_fees_paid, only: [:stripe_return]
  before_action :set_open_rps, only: [:index, :finalize, :review]

  def add_to_wait_list
    WaitListedStudent.create(wait_list_student_params)

    head :no_content
  end
  
  def add_to_wait_list_refresh
    @student = Student.find(params[:student_id])
    @section = Section.find(params[:section_id])
    @rp = @section.course.registration_period

    if WaitListedStudent.create(wait_list_student_params)
      flash[:notice] = "#{@student.first_name} has been added to the waitlist for #{@section.name}"
      redirect_to new_parent_registration_period_registration_path(current_parent.id, @rp.id, { student: @student })
    else
      flash[:warning] = "Student was not added to the waitlist"
      redirect_back fallback_location: new_parent_registration_period_registration_path(current_parent.id, @rp.id, { student: @student }) 
    end
  end
  
  def choose_class
    @student = Student.find(params[:student_id])
    @section = Section.find(params[:section_id])
    @registration = Registration.new(student_id: @student.id, section_id: @section.id,
      status: :selected, user: current_parent)
    if @registration.save
      @registered = true
      set_course_and_tuition(@rp)
    else
      @registered = false
      @class_is_full = @registration.section.at_max?
      @error_content = @registration.errors.full_messages.first
    end
  end

  def complete_parent_info
    @student_id = params[:student_id]
  end


  def create
    tuesday = Registration.new(tuesday_params)
    thursday = Registration.new(thursday_params)
    @registration_period = RegistrationPeriod.find(params[:registration_period_id])
    
    [tuesday, thursday].each do |reg|
      next if reg.section.nil?
      unless reg.save
        @errors = reg.errors.full_messages
      end
    end

    if @errors.present?
      flash[:warning] = @errors
      redirect_back fallback_location: new_parent_registration_period_registration_path(current_parent, @registration_period)
    else
      flash[:notice] = "Registration was successful"
      redirect_to new_parent_registration_period_registration_path(current_parent, @registration_period)
    end
  end

  def create_checkout_session
    unless line_items_for_checkout.empty?
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: line_items_for_checkout,
        mode: 'payment',
        discounts: current_parent.students.count <= 1 ? nil : sibling_discount,
        success_url:  stripe_return_url(parent_id: current_parent.id, registration_period_id: @rp.id),
        cancel_url: registrations_finalize_url(failed: true),
        customer_email: current_parent.email,
        client_reference_id: current_parent.id,
        metadata: {
          parent_id: current_parent.id,
          registration_period_id: @rp.id
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
      set_course_and_tuition(@rp)
    else
      @dropped = false
    end
  end

  def finalize
    @administrative_fee = fee_paid?(Product.administrative_fee(@rp)) ? 0 : Invoice.administrative_fee(@rp)
    @enrolled_students = current_parent.students.enrolled(@rp)
    @discount = current_parent.enrolled_students_count(@rp) > 1 && discount_not_yet_applied?(@rp) ? Invoice.discount(@rp) : nil
    
    @fees = []
    @fees << ["Administrative Fee", @administrative_fee]

    @enrolled_students.each do |s|
      unless s.reg_fee(@rp).nil? || fee_paid?(s.reg_fee(@rp), s.id)  
        @fees << ["#{s.full_name} Registration Fee", s.reg_fee(@rp).try(:unit_price)]
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

    @registration_period = @open_rps.first
    @browser = browser.name
    @student = Student.find(params[:student_id])
    @closed = current_parent.invoice_closed?

    @available_sections = available_sections(@student, @registration_period)
    @days = %w(tuesday thursday)
    @time_blocks = time_blocks
  end

  def new
    @students = current_parent.students
    @registration_period = RegistrationPeriod.find(params[:registration_period_id])
    @registration = Registration.new

    unless params[:student].nil?
      @student = Student.find(params[:student])
      @tuesday = @registration_period.sections.where(day: "Tuesday").select { |s| s.grades.split(',').include?(@student.grade.to_s) && !s.at_max? }
      @thursday = @registration_period.sections.where(day: "Thursday").select { |s| s.grades.split(',').include?(@student.grade.to_s) && !s.at_max? }
      @tuesday_full = @registration_period.sections.where(day: "Tuesday").select { |s| s.grades.split(',').include?(@student.grade.to_s) && s.at_max? } 
      @thursday_full = @registration_period.sections.where(day: "Thursday").select { |s| s.grades.split(',').include?(@student.grade.to_s) && s.at_max? }
    end
   
    render "new"
  end

  # def choose_student
  #   @student = Student.find(params[:choose_student][:student_id])
  #   @student_id = @student.id
  #   @user_id = current_parent.id
  #   redirect_to new_parent_registration_period_registration_path(current_parent.id, params[:registration_period_id], { student: @student })
  # end

  def review
    @enrolled_students = current_parent.students.enrolled(@rp)
    @not_enrolled = current_parent.students - @enrolled_students
  end

  def select_student
    @parent = Parent.find(params[param_label])
    @registration_period = RegistrationPeriod.find(params[:registration_period_id])
    @students = @parent.students
    @registration = Registration.new
  end

  def stripe_return
    @tuition_preference = TuitionPreference.new
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

  def update_selected_registrations
    selected_registrations = Registration.where(student_id: current_parent.students, status: 'selected', registration_period: @rp)

    selected_registrations.each do |r|
      r.update(status: :pending)
    end
  end

  private

  def available_sections(student, rp)
    Section.all.select do |c| 
      c.grades.split(',').include?(student.grade.to_s) && 
      c.course.registration_period == rp 
    end
  end

  def discount_not_yet_applied?(rp)
    !InvoiceLineItem.find_by(parent: current_parent, product: Product.sibling_discount(rp))
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
    current_parent.registered_students(@rp).each do |s|
      unless InvoiceLineItem.find_by(parent: current_parent, registration_period_id: @rp.id, student_id: s.id)
        items << {
          name: "Registration Fee - #{s.full_name}",
          amount: (s.reg_fee(@rp).unit_price * 100).to_i,
          quantity: 1,
          currency: "usd",
        }
      end
    end

    unless InvoiceLineItem.find_by(parent: current_parent, product: Product.administrative_fee(@rp))
      items << {
        name: "Administrative Fee - #{current_parent.full_name}",
        amount: (Product.administrative_fee(@rp).unit_price * 100).to_i,
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
    admin_fee = Product.administrative_fee(@rp)
    
    ActiveRecord::Base.transaction do 
      i = Invoice.find_or_create_by(parent: current_parent)
      
      InvoiceLineItem.find_or_create_by(invoice: i, parent: current_parent, product: admin_fee, quantity: 1)
      current_parent.registered_students.each do |s|
        InvoiceLineItem.find_or_create_by(invoice: i, parent: current_parent, student_id: s.id, product: s.reg_fee(@rp), quantity: 1)
      end
      unless current_parent.students.count <= 1 || InvoiceLineItem.find_by(parent: current_parent, product: Product.sibling_discount(@rp))
        InvoiceLineItem.create(invoice: i, parent: current_parent, product: Product.sibling_discount(@rp), quantity: 1)
      end
    end 
  end

  def set_course_and_tuition(rp)
    @course_fees = @current_student.rp_courses(rp).inject(0) { |sum, c| sum + c.fee }
    @student_tuition_total = @current_student.rp_courses(rp).inject(0){ |sum, c| sum + c.semester_tuition }
    @formatted_course_fees = "$%.2f" % @course_fees
    @formatted_student_tuition_total = "$%.2f" % @student_tuition_total
  end

  def set_current_student
    @current_student = Student.find(params[:student_id])
  end

  def set_open_rps
    @open_rps = RegistrationPeriod.open
    
    if @open_rps.empty? 
      @student = Student.find(params[:student_id])
      flash[:notice] = "No registrations are open at this time"
      redirect_back(fallback_location: parent_path(id: @student.parent.id)) 
    end
  end

  def set_total_fees_and_tuition(rp)
    @parent_tuition_total = current_parent.rp_courses(rp).inject(0){ |sum, e| sum + e.semester_tuition } 
    @parent_total_course_fees = current_parent.rp_courses(rp).inject(0){ |sum, e| sum + e.fee }
  end


  def sibling_discount
    return if current_parent.students.enrolled(@rp).count <= 1 || InvoiceLineItem.find_by(parent: current_parent, product: Product.sibling_discount(@rp))

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

  def param_label
    param_label = current_parent.class.to_s.downcase.to_sym
  end

  def parent_params
    params.require(param_label).permit(:id, :first_name, :last_name, :email, :phone_number,
      :secondary_email, :street_address_1, :street_address_2, :city, :state, :zip_code,
      :tuition_preference, :payment_preference)
  end

  def registration_params
    params.permit(

    )
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def time_blocks
    result = {
      tuesday: {
        "08:30": {
          label_text: "Block 1<br>8:30-9:45",
          sections: []
        },
        "09:45": {
          label_text: "Block 2<br>9:45-11:00",
          sections: []
        },
        "11:30": {
          label_text: "Block 3<br>11:30-1:00",
          sections: []
        },
        "13:00": {
          label_text: "Block 4<br>1:00-2:30",
          sections: []
        },
        "14:30": {
          label_text: "Block 5<br>2:30-3:30",
          sections: []
        } 
      },
      thursday: {
        "08:30": {
          label_text: "Block 1<br>8:30-9:45",
          sections: []
        },
        "09:45": {
          label_text: "Block 2<br>9:45-11:00",
          sections: []
        },
        "11:30": {
          label_text: "Block 3<br>11:30-1:00",
          sections: []
        },
        "13:00": {
          label_text: "Block 4<br>1:00-2:30",
          sections: []
        },
        "14:30": {
          label_text: "Block 5<br>2:30-3:30",
          sections: []
        } 
      }
    }
  
    @available_sections.each do |s|
      days = case s.day
      when "Tuesday"
        [:tuesday]
      when "Thursday"
        [:thursday]
      when "Tuesday/Thursday"
        [:tuesday, :thursday]
      end

      days.each do |d|
        result[d][s.start_time.strftime("%H:%M").to_sym][:sections] << s
      end
    end
    
    result
  end

  def tuesday_params
    params.permit( :student_id, :user_id)
          .merge(params.require(:tuesday_options).permit(:section_id))
  end
  
  def thursday_params
    params.permit( :student_id, :user_id)
          .merge(params.require(:thursday_options).permit(:section_id))
  end
  
  def wait_list_student_params
    params.permit(:section_id, :student_id)
  end
end
