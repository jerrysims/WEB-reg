class StudentShadowsController < ApplicationController
  def create
    @student = Student.find(params[:student_shadow][:student_id])
    @student_shadow = StudentShadow.create(student_shadow_params)
    if @student_shadow.errors[:student].include? 'may not shadow more than twice'
      drop_schedule
      @student_shadow = StudentShadow.create(student_shadow_params)
      @student.reload
    end
    @available_shadow_spots = ShadowSpot.select {
      |ss| ss.subject.grade == @student.grade } .select {
      |ss| !@student.shadow_spots.include?(ss) }.select {
    }
  end

  def edit
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

  def drop_schedule
    @student.student_shadows.destroy_all
    @student.shadow_spots.destroy_all
  end

end
