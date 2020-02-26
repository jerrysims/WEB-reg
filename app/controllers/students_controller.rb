class StudentsController < ApplicationController
  def index
    @students = current_parent.students
    send_mail(params[:student_id]) if params[:commit] == "Accept Schedule"
  end

  def create
    @student = Student.where(student_params).first
    @student = Student.create(student_params) if @student.nil?
    @students = current_parent.students
    render 'index'
  end

  def edit
  end

  def new
  end

  def show
  end

  def update
    student = Student.find(params[:id])
    student.update_attributes(params[:student].permit(:grade))
    student.update_attributes(confirmed_grade: true)
    redirect_to ({ action: "confirm_grade", controller: "enrollments" })
  end

  def change_lunch
    @student = Student.find(params[:id])
    @student.update_attribute(:lunch, !!params[:lunch])
  end

  private
  def send_mail(student)
    current_student = Student.find(student)
    ParentMailer.shadow_schedule_email(current_parent, current_student).deliver_now
  end

  def student_params
    params.require(:student).permit(:first_name, :grade, :last_name, :parent_id).merge(parent_id: current_parent.id)
  end

end
