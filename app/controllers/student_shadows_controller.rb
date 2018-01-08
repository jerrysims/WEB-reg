class StudentShadowsController < ApplicationController
  def create
    @student_shadow = StudentShadow.create(student_shadow_params)
    @shadow_spot = ShadowSpot.find(params[:student_shadow][:shadow_spot_id])
    @student = Student.find(params[:student_shadow][:student_id])
    @available_shadow_spots = ShadowSpot.select {
      |ss| ss.subject.grade == @student.grade } .select {
      |ss| !@student.shadow_spots.include?(ss)
    }
  end

  def edit
    @student = Student.find(params[:id])
    @shadow_spots = @student.shadow_spots
    @available_shadow_spots = ShadowSpot.select {
      |ss| ss.subject.grade == @student.grade } .select {
      |ss| !@student.shadow_spots.include?(ss)
    }
  end

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
    @available_shadow_spots = ShadowSpot.select {
      |ss| ss.subject.grade == @student.grade } .select {
      |ss| !@student.shadow_spots.include?(ss)
    }
  end

  private

  def student_shadow_params
    params.require(:student_shadow).permit(:student_id, :shadow_spot_id)
  end

end
