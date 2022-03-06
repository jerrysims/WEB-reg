class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_current_student, only: [:choose_class, :drop_class, :index]
  before_action :set_course_fees, only: [:choose_class, :drop_class, :index]

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
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: "Registration & Admin Fees",
        amount: total_fees * 100,
        quantity: 1,
        currency: "usd"
      }],
      mode: 'payment',
      success_url:  stripe_return_url,
      cancel_url: registrations_finalize_url,
      customer_email: current_parent.email,
      client_reference_id: current_parent.id,
      metadata: {
        parent_id: current_parent.id
      }
    })

    render json: session
  end

  def drop_class
    @section = Section.find(params[:section_id])
    r = Registration.where(["student_id = ? and section_id = ?", params[:student_id], params[:section_id]]).first
    if r
      r.destroy
      @dropped = true
    else
      @dropped = false
    end
  end

  def finalize
    @administrative_fee = Invoice.administrative_fee
    @registration_fee = Invoice.registration_fee
    @enrolled_students = current_parent.students.select { |s| s.sections.count > 0 }
    student_count = current_parent.enrolled_students_count
    @discount = student_count > 1 ? Invoice.discount : nil
    @invoice_total = total_fees
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
  end

  def stripe_return
    @semester, @monthly = Invoice.tuition_totals(current_parent)
    @payment_preference_section = payment_preference_section
    @tuition_total = tuition_total
    @donation = Invoice.get_donation(current_parent) || InvoiceLineItem.new
    @checked = get_donation_radio_check(@donation.quantity)
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
    @payment_preference_section = payment_preference_section
    @semester, @monthly = Invoice.tuition_totals(current_parent)
    @tuition_total = tuition_total
    redirect_to action: "finalize"
  end

  private

  def available_sections(student)
    Section.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def get_donation_radio_check(amount)
    [0,10,25,50].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def get_program_donation_radio_check(amount)
    [0,75,100,150].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def payment_preference_section
    current_parent.tuition_preference && current_parent.payment_preference ? "preference" : "no_preference"
  end

  def set_course_fees
    @course_fees = @current_student.courses.inject(0){|sum,e| sum + e.fee }
  end

  def set_current_student
    @current_student = Student.find(params[:student_id])
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
