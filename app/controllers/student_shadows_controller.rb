class StudentShadowsController < ApplicationController
  def index
    @student = Student.find(params[:student])
    @grade = @student.grade
    @shadow_spots = []
    ShadowSpot.all.each do |ss|
      @shadow_spots << "#{ss.date}, #{ss.time}, #{ss.subject.name}"
    end
  end

  def new
    @student = Student.find(params[:student_id]) unless params[:student_id].nil?
  end

  def create
    @shadow_spot = ShadowSpot.find(params[:student_shadow][:shadow_spot])
    @student = Student.find(params[:student_shadow][:student])
    StudentShadow.create(student: @student, shadow_spot: @shadow_spot)
  end

end
