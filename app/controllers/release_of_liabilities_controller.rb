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

  def new
    @release_of_liability = ReleaseOfLiability.new
  end

  private
  def set_parent
    @parent = current_parent
  end

  def release_of_liability_params
    params.require(:release_of_liability).permit(
      :waiver_terms,
      :dalewood_terms,
      :signature
    )
  end

  def parent_params
    params.require(:release_of_liability).require(:parent).permit(:id, :first_name, :last_name)
  end
end
