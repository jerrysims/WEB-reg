class PhotoConsentsController < ApplicationController
  before_action :set_parent

  def create
    @photo_consent = PhotoConsent.new(photo_consent_params)

    if @photo_consent.update(parent_id: parent_params[:id])
      flash[:notice] = "Photo Consent successfully saved"
      redirect_to root_path
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
  def set_parent
    @parent = current_parent
  end

  def photo_consent_params
    params.require(:photo_consent).permit(
      :permission_and_consent,
      :signature
    )
  end

  def parent_params
    params.require(:photo_consent).require(:parent).permit(:id, :first_name, :last_name)
  end
end
