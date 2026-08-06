class TeachersController < ApplicationController
  before_action :set_teacher, only: :show

  def show
    @today_school_day = SchoolDay.find_by(date: Date.current)
  end

  private
  
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
end