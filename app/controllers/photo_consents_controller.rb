class PhotoConsentsController < ApplicationController
  before_action :set_parent
  before_action :set_rp
  before_action :set_student, except: [:update]
  before_action :dont_show_header

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

  def show
    @photo_consent = PhotoConsent.find(params[:id])
  end
  
  def update
    @photo_consent = PhotoConsent.find params[:id]
    if @photo_consent.update photo_consent_params
      flash[:notice] = "Photo Consent successfully updated"
      redirect_to root_path
    else
      flash[:alert] = "Form could not be updated. Please ensure all required fields are completed"
      redirect_back fallback_location: edit_parent_registration_period_photo_consent_path(
        parent_id: @parent.id, 
        registration_period_id: @rp.id,
        id: @parent_agreement.id
      )
    end
  end

  private
  def dont_show_header
    @dont_show_header = params[:dont_show_header]
  end

  def param_label
    param_label = current_parent.class.to_s.downcase.to_sym
  end

  def set_parent
    @parent = current_parent
  end

  def set_student
    unless action_name == "create"
      unless params[:student_id].nil?
        @student = Student.find(params[:student_id])
      else
        @student = current_parent.students.first
      end
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
