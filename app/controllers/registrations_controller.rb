class RegistrationsController < ApplicationController

  def index
    redirect_to(
      action: "complete_parent_info",
      student_id: params[:student_id]
      ) unless current_parent.valid?(:course_registration)

    @browser = browser.name
    @student = Student.find(params[:student_id])
    @closed = current_parent.invoice_closed?

    @available_courses = get_available_courses(@student)
    day_order = %w(Tuesday Thursday Tuesday/Thursday)
    @days = @available_courses.map { |c| c.day }.uniq.sort_by { |c| day_order.index(c) }
    @start_times = @available_courses.map { |c| c.start_time }.uniq.sort
    @tuesday_courses = []
    @thursday_courses = []

    @available_courses.map do |c|
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

  def add_to_wait_list
    WaitListedStudent.create(wait_list_student_params)

    head :no_content
  end

  def choose_class
    @student = Student.find(params[:student_id])
    @course = Course.find(params[:course_id])

    @registration = Registration.new(student: @student, course: @course)

    if @registration.save
      @registered = true
    else
      @registered = false
      @class_is_full = @registration.course.at_max?
      @error_content = @registration.errors.full_messages.first
    end
  end

  def complete_parent_info
    @student_id = params[:student_id]
  end

  def drop_class
    @course = Course.find(params[:course_id])
    r = Registration.where(["student_id = ? and course_id = ?", params[:student_id], params[:course_id]]).first
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
    @enrolled_students = current_parent.students.select { |s| s.courses.count > 0 }
    student_count = current_parent.enrolled_students_count
    @discount = student_count > 1 ? (student_count - 1) * Invoice.discount : nil
    @invoice_total = Invoice.initial_invoice_total(current_parent)
    @annual, @semester, @monthly = Invoice.get_tuition_totals(current_parent)
    @payment_preference_section = get_payment_preference_section
    @tuition_total = get_tuition_total
    @donation = Invoice.get_donation(current_parent) || InvoiceLineItem.new
    @program_donation = Invoice.get_program_donation(current_parent) || InvoiceLineItem.new
    @checked = get_donation_radio_check(@donation.quantity)
    @program_donation_checked = get_program_donation_radio_check(@program_donation.quantity)
  end

  def review
    @student = Student.find(params[:student_id])
  end

  def update_parent
    current_parent.update_attributes(parent_params)

    if current_parent.valid?(:course_registration)
      # TODO: I must figure out how to get the student's information to this point
      redirect_to(action: "index", student_id: params[:student_id])
    else
      redirect_to :back
    end
  end

  def update_tuition_preference
    current_parent.update_attributes(tuition_preference: params[:parent][:tuition_preference])
    @payment_preference_section = get_payment_preference_section
    @annual, @semester, @monthly = Invoice.get_tuition_totals(current_parent)
    @tuition_total = get_tuition_total
  end

  private

  def get_available_courses(student)
    courses = Course.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def get_donation_radio_check(amount)
    [0,10,25,50].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def get_program_donation_radio_check(amount)
    [0,75,100,150].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def get_payment_preference_section
    current_parent.tuition_preference ? "preference" : "no_preference"
  end

  def get_tuition_total
    case current_parent.tuition_preference
      when "Annual"
        @annual
      when "Semester"
        @semester
      when "Monthly"
        @monthly
      else
        @annual
    end
  end

  def parent_params
    params.require(:parent).permit(:id, :first_name, :last_name, :email, :phone_number,
      :street_address_1, :street_address_2, :city, :state, :zip_code)
  end

  def wait_list_student_params
    params.permit(:course_id, :student_id)
  end

end
