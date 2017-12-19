class TeacherController < ApplicationController
  def create
    @teacher = Teacher.create(user_params)
  end

  private

  def user_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :subject_id)
  end
end
