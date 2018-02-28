class EnrollmentsController < ApplicationController
  def new
    redirect_to(action: "select_student") if should_redirect_to_select_student?

    @student = Student.find(params[:student_id]) unless params[:student_id].nil?
  end

  def update
  end

  def select_student
    @students = current_parent.students
  end

  def student_info
    @student = Student.find(params[:id])
    if @student
      @student.update_attributes(student_info_params)
    end
    render :courses


  end

  private

  def student_info_params
    params.require(:student).permit(:id, :first_name, :last_name, :student_email, :grade,
      :date_of_birth, :learning_differences, :emergency_contact, :emergency_phone)
  end

  def should_redirect_to_select_student?
    params[:student_id].nil? && !current_parent.students.empty?
  end
end
