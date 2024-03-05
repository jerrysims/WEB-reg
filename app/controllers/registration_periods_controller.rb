class RegistrationPeriodsController < ApplicationController
  before_action :set_registration_period, only: [:select_student]
  def index
    @open_academic_rps= RegistrationPeriod.open.academic
    @open_extracurricular_rps = RegistrationPeriod.open.extracurricular
    @no_open_rps = RegistrationPeriod.open.empty?
  end

  def select_student
    @students = current_parent.students
  end

  private
  def set_registration_period
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end 
end
