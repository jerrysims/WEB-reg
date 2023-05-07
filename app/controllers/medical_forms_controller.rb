class MedicalFormsController < ApplicationController
  before_action :set_parent
  before_action :set_student

  def create
    @medical_form = MedicalForm.new(medical_form_params)
    if @medical_form.update(student_id: student_params[:id])
      flash[:notice] = "Medical Form successfully saved"
      redirect_to root_path
    else
      flash[:warning] = "There was an error saving the form"
      render :new
    end
  end

  def edit
    @form_action = :update
    @medical_form = @student.medical_form
  end
  
  def new
    @form_action = :create
    @medical_form = MedicalForm.new
  end

  def update
    @medical_form = MedicalForm.find(params[:id])
    @medical_form.update(medical_form_params)

    redirect_to root_path
  end

  private
  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_parent
    @parent = current_parent
  end

  def medical_form_params
    params.require(:medical_form).permit(
      :parent2_first_name,
      :parent2_last_name,
      :parent2_phone,
      :emergency_contact_first_name,
      :emergency_contact_last_name,
      :emergency_contact_relationship,
      :known_allergies,
      :medical_needs_or_concerns,
      :current_medications,
      :physician_first_name,
      :physician_last_name,
      :physician_phone,
      :medical_insurance_provider,
      :medical_insurance_policy_number,
      :preferred_hospital,
      :pain_reliever_permission,
      :medical_care_consent,
      :signature,
      :student_id
    )
  end

  def student_params
    params.require(:medical_form).require(:student).permit(:id, :first_name, :last_name)
  end
end
