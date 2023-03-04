class AdminsController < ApplicationController
  before_action :confirm_admin

  def clear_search_filters
    binding.pry
  end

  def dashboard
  end

  def open_seats
    @q = Section.joins(:course).search(params[:q])
    @sections = @q.result
  end

  def student_schedule
    @student = Student.find(params[:student_id])
  end

  def students_schedules
  end
  
  private
  
  def confirm_admin     
    current_parent.has_role? :admin
  end
end