class ParentsController < ApplicationController
  def show
    @parent = Parent.find(params[:parent_id])
    @students = @parent.students
  end
end
