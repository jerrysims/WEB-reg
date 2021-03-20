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
      # TEMP - THIS MUST LINE MUST BE REMOVED FOR REGISTRATION
      # redirect_to student_view_course_list_path(@student.id)
      redirect_to root_path
    else
      @errors = @student.errors.full_messages
      redirect_to({ action: "new", student: params[:student], new_student: 1, errors: @errors })
    end
  end

  def new
    @student = Student.new
  end

  def view_course_list
    @student = Student.find(params[:student_id])
    @available_courses = @student.available_courses
    @subject_areas = @available_courses.map(&:subject_area).uniq
  end

  def update
    student = Student.find(params[:id])

    if student.update_attributes(params[:student].permit(:grade))
      student.update_attributes(confirmed_grade: true)
    end

    redirect_to root_path
  end

  def update_web_email
    student = Student.find(params[:student_id])
    student.update web_email: params[:student][:web_email]

    redirect_to root_path
  end

  private
  def student_params
    params.require(:student).permit(
      :date_of_birth,
      :emergency_contact,
      :emergency_phone,
      :first_name,
      :grade,
      :grade,
      :last_name,
      :learning_differences,
      :nickname,
      :pronouns,
      :race,
      :student_email,
      :web_email
    )
  end
end
