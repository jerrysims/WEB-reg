class EnrollmentsController < ApplicationController
  def new
    redirect_to(action: "select_student") if should_redirect_to_select_student?

    @errors = params[:errors]

    if params[:student_id].nil?
      @student = params[:student] ? Student.new(student_info_params) : Student.new
    else
      @student = Student.find(params[:student_id])
    end
  end

  def update
  end

  def new_student_info
    params[:student][:parent_id] = current_parent.id
    @student = Student.create(student_info_params)

    if @student.valid?
      redirect_to(action: "view_course_list", student_id: @student.id)
    else
      @errors = @student.errors.full_messages
      redirect_to({ action: "new", student: params[:student], new_student: 1, errors: @errors })
    end
  end

  def select_student
    @students = current_parent.students
  end

  def student_info
    @student = Student.find(params[:id])
    if @student
      @student.update_attributes(student_info_params)
    end
    redirect_to(action: "view_course_list", student_id: @student.id)
  end

  def view_course_list
    @student = Student.find(params[:student_id])
    @available_courses = get_available_courses(@student).uniq { |c| c.name }
  end

  private

  def get_available_courses(student)
    Course.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def student_info_params
    params.require(:student).permit(:id, :first_name, :last_name, :student_email, :grade,
      :date_of_birth, :learning_differences, :emergency_contact, :emergency_phone, :parent_id)
  end

  def should_redirect_to_select_student?
    params[:student_id].nil? && !current_parent.students.empty? && !params[:new_student]
  end
end
