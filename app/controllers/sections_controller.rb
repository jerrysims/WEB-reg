class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @students = @section.students
  end
end