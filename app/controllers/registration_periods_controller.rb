class RegistrationPeriodsController < ApplicationController
  before_action :set_registration_period, only: [:select_student]
  def index
    @open_academic_rps= open_rps(:academic)
    @open_extracurricular_rps = open_rps(:extracurricular)

    @no_open_rps = @open_academic_rps.empty? && @open_extracurricular_rps.empty?
  end

  def select_student
    @students = current_parent.students
  end

  private
  def open_rps(rp_type)
    if current_parent.is_admin?
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
