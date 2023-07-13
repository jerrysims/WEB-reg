class TeachersController < ApplicationController
  before_action :set_teacher, only: :show

  def parent_contact_list
    @teacher = Teacher.find(params[:teacher_id])
    @sections = @teacher.sections
    @students = Student.where(id: Registration.includes(:section, :student).where(section: @teacher.sections).pluck(:student_id)).order(:last_name)
  end

  def show
  end

  private
  
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
end