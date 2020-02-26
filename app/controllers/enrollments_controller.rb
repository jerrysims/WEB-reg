class EnrollmentsController < ApplicationController
  def new
    redirect_to(action: "select_student") if should_redirect_to_select_student?
    @errors = params[:errors]

    if params[:student_id].nil?
      @student = params[:student] ? Student.new(student_info_params) : Student.new
    else
      @student = Student.find(params[:student_id])
    end

    redirect_to(action: "view_course_list", student_id: @student.id) if @student.valid?(:course_registration)
  end

  def update
  end

  def confirm_grade
    @unconfirmed_students = current_parent.students.select { |s| !s.confirmed_grade? }
  end

  def new_student_info
    params[:student][:parent_id] = current_parent.id
    get_date_of_birth if params[:student][:date_of_birth].empty?
    @student = Student.create(student_info_params)

    if @student.valid?
      redirect_to(action: "view_course_list", student_id: @student.id)
    else
      @errors = @student.errors.full_messages
      redirect_to({ action: "new", student: params[:student], new_student: 1, errors: @errors })
    end
  end

  def select_student
    redirect_to(action: "confirm_grade") if should_redirect_to_confirm_grade?

    @students = current_parent.students
  end

  def student_info
    @student = Student.find(params[:id])
    if @student
      if @student.update_attributes(student_info_params)
        redirect_to(action: "view_course_list", student_id: @student.id)
      else
        @errors = @student.errors.full_messages
        redirect_to({ action: "new", student: params[:student], new_student: 1, errors: @errors })
      end
    end
  end

  def view_course_list
    @student = Student.find(params[:student_id])
    @available_courses = get_available_courses(@student).uniq { |c| c.name }
    @subject_areas = @available_courses.map(&:subject_area).uniq
  end

  private

  def get_available_courses(student)
    Course.all.select { |c| c.grades.split(',').include?(student.grade.to_s) }
  end

  def get_date_of_birth
    params[:student][:date_of_birth] = "#{params[:year]}/#{params[:month]}/#{params[:day]}"
  end

  def student_info_params
    params.require(:student).permit(:id, :first_name, :last_name, :student_email, :grade,
      :date_of_birth, :learning_differences, :emergency_contact, :emergency_phone, :parent_id)
  end

  def should_redirect_to_confirm_grade?
    !current_parent.students.select { |s| !s.confirmed_grade? }.empty?
  end

  def should_redirect_to_select_student?
    params[:student_id].nil? && !current_parent.students.empty? && !params[:new_student]
  end
end
