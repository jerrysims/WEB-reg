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

  private

  def should_redirect_to_select_student?
    params[:student_id].nil? && !current_parent.students.empty?
  end
end
