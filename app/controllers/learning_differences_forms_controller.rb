class LearningDifferencesFormsController < ApplicationController
  before_action :set_parent
  before_action :set_student

  def create
    @learning_differences_form = LearningDifferencesForm.new(learning_differences_form_params)
     
    if @learning_differences_form.update(student: @student)
      flash[:notice] = "Learning Differences Form successfully saved"
      redirect_to student_learning_differences_form_path(@student, @learning_differences_form)
    else
      flash[:warning] = "There was an error saving the form"
      render :new
    end
  end

  def edit
    @form_action = :update
    @learning_differences_form = @student.learning_differences_form
  end

  def new
    @form_action = :create
    @learning_differences_form = LearningDifferencesForm.new
  end

  def show
    @learning_differences_form = LearningDifferencesForm.find(params[:id])
  end

  def update
    @learning_differences_form = LearningDifferencesForm.find(params[:id])
    if @learning_differences_form.update(learning_differences_form_params)
      flash[:notice] = "Learning Differences Form successfully updated"
      redirect_to student_learning_differences_form_path(@student, @learning_differences_form)
    else
      flash[:warning] = "There was an error updating the form"
      render :edit
    end
  end

  private
  def set_parent
    @parent = current_parent
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def learning_differences_form_params
    params.require(:learning_differences_form).permit(
      :learning_differences,
      :successful_accomodations,
      :home_accomodations,
      :anything_else,
      :student_id
    )
  end

  def parent_params
    params.require(:learning_differences_form).require(:parent).permit(:id, :first_name, :last_name)
  end
end
