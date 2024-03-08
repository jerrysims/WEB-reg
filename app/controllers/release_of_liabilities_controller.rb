class ReleaseOfLiabilitiesController < ApplicationController
  before_action :set_parent
  before_action :set_student
  before_action :set_rp

  def create
    @release_of_liability = ReleaseOfLiability.new(release_of_liability_params)

    if @release_of_liability.save!
      flash[:notice] = "Release of Liability successfully saved"
      render :show
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

  def show
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

  def set_student
    unless action_name == "create"
      @student = Student.find(params[:student_id])
    else
      @student = Student.find(params[:release_of_liability][:student_id])
    end
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def release_of_liability_params
    params.require(:release_of_liability).permit(
      :waiver_terms,
      :signature,
      :parent_id,
      :registration_period_id
    )
  end
end
