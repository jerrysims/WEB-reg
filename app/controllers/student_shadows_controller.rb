class StudentShadowsController < ApplicationController
  def index
    @student = Student.find(params[:student])
    @grade = @student.grade
    @shadow_spots = []
    ShadowSpot.all.each do |ss|
      @shadow_spots << "#{ss.date}, #{ss.time}, #{ss.subject.name}"
    end
  end

  def create
    @student = Student.new
    @shadow_spots = ShadowSpot.all
  end
end
