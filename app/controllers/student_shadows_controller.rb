class StudentShadowsController < ApplicationController
  def create
    @student = Student.find(params[:student_shadow][:student_id])
    unless params[:commit] == "Change Date"
      @student_shadow = StudentShadow.create(student_shadow_params)
      if @student_shadow.errors[:student].include? 'may not shadow more than twice'
        drop_schedule
        @student_shadow = StudentShadow.create(student_shadow_params)
        @student.reload
      end
    end
    @should_show_selection_box = get_should_show_selection_box(@student, params[:commit])
    @available_shadow_spots = ShadowSpot.select {
      |ss| ss.subject.grade == @student.grade } .select {
      |ss| !@student.shadow_spots.include?(ss)
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
    @should_show_selection_box = get_should_show_selection_box(@student)
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

  def get_should_show_selection_box(student, commit = nil)
    if (student.shadow_spots.count == 0 ||
        commit == "Add Additional class"
      )
      true
    elsif (student.shadow_spots.count == 2 && commit != "Change Date")
      false
    else
      true
    end
  end

end
