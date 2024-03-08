class PhotoConsentsController < ApplicationController
  before_action :set_parent
  before_action :set_rp
  before_action :set_student

  def create
    @photo_consent = PhotoConsent.new(photo_consent_params)

    if @photo_consent.save!
      flash[:notice] = "Photo Consent successfully saved"
      render :show
    else
      flash[:warning] = "There was an error saving the consent form"
      render :new
    end
  end

  def edit 
    @form_action = :update
    @photo_consent = current_parent.photo_consent
  end

  def new
    @form_action = :create
    @photo_consent = PhotoConsent.new
  end
  
  def update
    @photo_consent = PhotoConsent.find params[:id]
    @photo_consent.update photo_consent_params

    redirect_to root_path
  end

  private
  def param_label
    param_label = current_parent.class.to_s.downcase.to_sym
  end

  def set_parent
    @parent = current_parent
  end

  def set_student
    unless action_name == "create"
      @student = Student.find(params[:student_id])
    else
      @student = Student.find(params[:photo_consent][:student_id])
    end
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def photo_consent_params
    params.require(:photo_consent).permit(
      :parent_id,
      :permission_and_consent,
      :registration_period_id,
      :signature
    )
  end
end
