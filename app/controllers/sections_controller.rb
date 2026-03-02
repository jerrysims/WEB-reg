class SectionsController < ApplicationController
  def assign_grading_scale
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.joins(section: :course).where(section_id: @section.id, courses: { show_in_gradebook: true })
    @section.update(grading_scale_params)

    redirect_to teacher_section_gradebook_path(teacher_id: @teacher.id, section_id: @section.id)
  end
  
  def gradebook
    @teacher = Teacher.where(id: params[:teacher_id]).first || Parent.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.joins(:student, section: :course)
                                  .where(section_id: @section.id, courses: { show_in_gradebook: true })
                                  .order('students.last_name, students.first_name')
  end

  def reset_grading_scale
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.joins(section: :course).where(section_id: @section.id, courses: { show_in_gradebook: true })

    @section.update(grading_scale: nil)
    render :gradebook
  end

  def save_gradebook
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    @registrations = Registration.joins(section: :course).where(section_id: @section.id, courses: { show_in_gradebook: true })

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
    @registrations = Registration.joins(:registration_period, section: :course)
                                  .where(section_id: @section.id,
                                         registration_periods: { id: [RegistrationPeriod::CURRENT_RP.id, RegistrationPeriod::CURRENT_ACADEMIC_YEAR.id] },
                                         courses: { show_in_gradebook: true })
  end
  
  def update_grades
    @registration = Registration.find(params[:registration][:id])
    Rails.logger.debug("Registration Params: #{registration_params.inspect}")
    
    registration_params[:quarterly_scores_attributes].each do |_, score_params|
      if score_params[:id].present?
        quarterly_score = QuarterlyScore.find(score_params[:id])
        quarterly_score.update(score_params)
      else
        @registration.quarterly_scores.create(score_params)
      end
    end

    flash[:success] = "Grades updated successfully."
    respond_to do |format|
      format.js { render 'sections/update_grades' }
    end
  rescue => e
    flash[:error] = "There was an error updating the grades: #{e.message}"
    respond_to do |format|
      format.js { render js: "alert('There was an error updating the grades: #{e.message}');" }
    end
  end

  def publish_grades
    @teacher = Teacher.find(params[:teacher_id])
    @section = Section.find(params[:section_id])
    if @section.course&.show_in_gradebook
      @section.update(published: true)
      @section.quarterly_scores.update_all(published: true)
      redirect_to teacher_section_gradebook_path(@teacher, @section), notice: 'Grades have been published.'
    else
      redirect_to teacher_section_gradebook_path(@teacher, @section), alert: 'Section is not included in the gradebook.'
    end
  end

  private
  def gradebook_params
    params.require(:section).permit(registration: [:id, :student_id, :section_id, :q1_grade, :q2_grade, :q3_grade, :q4_grade])
  end

  def grading_scale_params
    params.require(:section).permit(:grading_scale)
  end

  def registration_params
    params.require(:registration).permit(
      :id, :student_id, :section_id, 
      quarterly_scores_attributes: [:id, :quarter, :grade, :_destroy]
    )
  end
end