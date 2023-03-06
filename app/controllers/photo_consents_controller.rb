class PhotoConsentsController < ApplicationController
  before_action :set_parent

  def create
    @photo_consent = PhotoConsent.new(photo_consent_params)

    if @photo_consent.save!
      flash[:notice] = "Photo Consent successfully saved"
      redirect_to root_path
    else
      flash[:warning] = "There was an error saving the consent form"
      render :new
    end
  end

  def new
    @photo_consent = PhotoConsent.new
  end

  private
  def set_parent
    @parent = current_parent
  end

  def photo_consent_params
    params.require(:photo_consent).permit(
      :permission_and_consent,
      :signature,
      :parent_id
    )
  end

  def parent_params
    params.require(:photo_consent).permit(:first_name, :last_name)
  end
end
