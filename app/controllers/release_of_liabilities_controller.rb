class ReleaseOfLiabilitiesController < ApplicationController
  before_action :set_parent

  def create
    @release_of_liability = ReleaseOfLiability.new(release_of_liability_params)

    if @release_of_liability.update(parent_id: parent_params[:id])
      flash[:notice] = "Release of Liability successfully saved"
      redirect_to root_path
    else
      flash[:warning] = "There was an error saving the release"
      render :new
    end
  end

  def edit
    @form_action = :update
    @release_of_liability = current_parent.release_of_liability
  end

  def new
    @form_action = :create
    @release_of_liability = ReleaseOfLiability.new
  end

  def update
    @release_of_liability = ReleaseOfLiability.find(params[:id])
    @release_of_liability.update release_of_liability_params

    redirect_to root_path
  end

  private
  def set_parent
    @parent = current_parent
  end

  def release_of_liability_params
    params.require(:release_of_liability).permit(
      :waiver_terms,
      :donelson_heights_terms,
      :signature
    )
  end

  def parent_params
    params.require(:release_of_liability).require(:parent).permit(:id, :first_name, :last_name)
  end
end
