class ParentAgreementsController < ApplicationController
  before_action :set_parent

  def create
    @parent_agreement = ParentAgreement.new(parent_agreement_params)
    if @parent_agreement.update(parent_id: parent_params[:id])
      flash[:notice] = "Parent Agreement successfully saved"
      redirect_to root_path
    else
      flash[:warning] = "There was an error saving the agreement"
      render :new
    end
  end

  def new
    @parent_agreement = ParentAgreement.new
  end

  private
  def set_parent
    @parent = current_parent
  end

  def parent_agreement_params
    params.require(:parent_agreement).permit(
      :agree_to_pay, 
      :late_fee_acknowledgment, 
      :no_refund_on_voluntary_withdraw,
      :prorate_on_requested_withdraw,
      :plan_to_volunteer,
      :volunteer_buyout,
      :late_fee_for_late_pickup,
      :signature,
    )
  end

  def parent_params
    params.require(:parent_agreement).require(:parent).permit(:id, :first_name, :last_name)
  end
end
