class RegistrationPeriodsController < ApplicationController
  before_action :set_registration_period, only: [:select_student, :view_schedules]

  def index
    @open_academic_rps= open_rps(:academic)
    @open_extracurricular_rps = open_rps(:extracurricular)

    @no_open_rps = @open_academic_rps.empty? && @open_extracurricular_rps.empty?
  end

  def view_schedules
    @enrolled_students = current_parent.students.enrolled(@rp)
    @not_enrolled = current_parent.students - @enrolled_students
  end

  def select_student
    @students = current_parent.students
  end

  private
  def open_rps(rp_type)
    if current_parent.admin?
      return RegistrationPeriod.where(rp_type: rp_type).where.not(status: :closed)
    elsif current_parent.is_a? Teacher
      return RegistrationPeriod.where(status: [:teachers, :returning, :all], rp_type: rp_type)
    elsif current_parent.is_returning?
      return RegistrationPeriod.where(status: [:returning, :all], rp_type: rp_type)
    else
      return RegistrationPeriod.where(status: :all, rp_type: rp_type)
    end
    
    nil
  end

  def set_registration_period
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end 
end
