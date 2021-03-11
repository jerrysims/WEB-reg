class StudentsController < ApplicationController
  # def index
  #   @students = current_parent.students
  #   send_mail(params[:student_id]) if params[:commit] == "Accept Schedule"
  # end
  #
  def create
    @student = Student.new(student_params)
    @student.update_attributes(
      date_of_birth: Date.strptime(student_params[:date_of_birth], "%m/%d/%Y"),
      parent: current_parent
    )
    if @student.save
      redirect_to student_view_course_list_path(@student.id)
    else
      @errors = @student.errors.full_messages
      redirect_to({ action: "new", student: params[:student], new_student: 1, errors: @errors })
    end
  end

  # def edit
  # end
  #
  def new
    @student = Student.new
  end

  def view_course_list
    @student = Student.find(params[:student_id])
    @available_courses = @student.available_courses
    @subject_areas = @available_courses.map(&:subject_area).uniq
  end

  #
  # def show
  # end
  #
  # def update
  #   student = Student.find(params[:id])
  #   student.update_attributes(params[:student].permit(:grade))
  #   student.update_attributes(confirmed_grade: true)
  #   redirect_to ({ action: "confirm_grade", controller: "enrollments" })
  # end
  #
  # def change_lunch
  #   @student = Student.find(params[:id])
  #   @student.update_attribute(:lunch, !!params[:lunch])
  # end
  #
  private
  # def send_mail(student)
  #   current_student = Student.find(student)
  #   ParentMailer.shadow_schedule_email(current_parent, current_student).deliver_now
  # end
  #
  def student_params
    params.require(:student).permit(
      :first_name,
      :grade,
      :last_name,
      :student_email,
      :grade,
      :date_of_birth,
      :learning_differences,
      :emergency_phone,
      :emergency_contact
    )
  end
end
