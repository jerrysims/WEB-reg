class SectionsController < ApplicationController
  def assign_grading_scale
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.where(section: @section)
    @section.update(grading_scale_params)

    redirect_to teacher_section_gradebook_path(teacher_id: @teacher.id, section_id: @section.id)
  end
  
  def gradebook
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.where(section: @section).joins(:student).order(:last_name, :first_name)
  end

  def reset_grading_scale
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.where(section: @section)

    @section.update(grading_scale: nil)
    render :gradebook
  end

  def save_gradebook
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.where(section: @section)

    gradebook_params[:registration].each do |gb|
      r = Registration.find(gb[:id])

      [:q1_grade, :q2_grade, :q3_grade, :q4_grade].each do |grade|
        r.update_attribute(grade, gb[grade]) if gb[grade].present?
      end

    end

    render :gradebook
  end

  def show
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:id])
    @students = @section.students
  end

  private
  def gradebook_params
    params.require(:section).permit(registration: [:id, :student_id, :section_id, :q1_grade, :q2_grade, :q3_grade, :q4_grade])
  end


  def grading_scale_params
    params.require(:section).permit(:grading_scale)
  end
end