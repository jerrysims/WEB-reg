class RegistrationsController < ApplicationController
  def index
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

    # check_time_conflicts
    # check_for_prerequisites
  end

  private

  def get_available_courses(student)
    Course.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end
end
