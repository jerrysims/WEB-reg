class RegistrationsController < ApplicationController
  def index
    redirect_to(
      action: "complete_parent_info",
      student_id: params[:student_id]
      ) unless current_parent.valid?(:course_registration)


    @student = Student.find(params[:student_id])

    @available_courses = get_available_courses(@student)
    day_order = %w(Monday Tuesday Wednesday Thursday Friday)
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
      end
    end
  end

  def choose_class
    @student = Student.find(params[:student_id])
    @course = Course.find(params[:course_id])

    @registration = Registration.new(student: @student, course: @course)

    if @registration.save
      @registered = true

    else
      @registered = false
      @error_content = @registration.errors.full_messages.first
    end
  end

  def complete_parent_info

    @student_id = params[:student_id]
  end

  def finalize
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

  private

  def get_available_courses(student)
    Course.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def parent_params
    params.require(:parent).permit(:id, :first_name, :last_name, :email, :phone_number,
      :street_address_1, :street_address_2, :city, :state, :zip_code)
  end
end
