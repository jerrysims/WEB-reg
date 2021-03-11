class ParentsController < ApplicationController
  before_action :authenticate_parent!

  def confirm_grade
    @unconfirmed_students = current_parent.students.unconfirmed
  end

  def show
    redirect_to parent_confirm_grade_path(current_parent.id) if should_redirect_to_confirm_grade?

    @students = current_parent.students
  end

  private
  def should_redirect_to_confirm_grade?
    current_parent.students.unconfirmed.count > 0
  end

end
