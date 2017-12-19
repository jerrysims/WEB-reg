class SubjectController < ApplicationController
  def create
    @subject = Subject.create(user_params)
  end

  private

  def user_params
    params.require(:subject).permit(:name, :grade)
  end
end
