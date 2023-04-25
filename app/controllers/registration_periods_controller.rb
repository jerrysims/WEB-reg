class RegistrationPeriodsController < ApplicationController
  def index
    @open_academic_rps= RegistrationPeriod.open.academic
    @open_extracurricular_rps = RegistrationPeriod.open.extracurricular
  end
end
