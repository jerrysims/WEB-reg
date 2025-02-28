class StudentsController < ApplicationController
  before_action :check_for_locked_parent
  before_action :set_rp, only: [:view_course_list, :choose_classes]
  before_action :set_student, only: [:view_course_list, :choose_classes, :show, :edit, :update, :destroy]

  def choose_classes
  end

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

  def edit
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def view_course_list
    @student = Student.find(params[:student_id])

    redirect_to edit_student_path(@student.id) if should_update? @student
    @available_courses = @student.available_courses(@rp)
    @subject_areas = @available_courses.map(&:subject_area).uniq
  end

  def update
    @student = Student.find params[:id]
    @student.update student_params

    redirect_to student_view_course_list_path(student_id: @student.id)
  end

  def update_grade_confirmed
    student = Student.find(params[:student_id])

    student.update_column(:grade, params[:student][:grade])
    student.update_column(:confirmed_grade,  true)

    redirect_to root_path
  end

  def update_web_email
    student = Student.find(params[:student_id])
    student.update_column :web_email, params[:student][:web_email]

    redirect_to root_path
  end

  def show
  end

  private
  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def set_student
    @student = Student.find(params[:id] || params[:student_id])
  end

  def should_update? student
    ! student.valid?
  end

  def student_params
    params.require(:student).permit(
      :date_of_birth,
      :emergency_contact,
      :emergency_phone,
      :first_name,
      :grade,
      :last_name,
      :learning_differences,
      :nickname,
      :pronouns,
      :race,
      :learning_differences_flag,
      additional_contacts_attributes: [
        :id,
        :first_name,
        :last_name,
        :email,
        :phone,
        :_destroy
      ]
    )
  end
end
