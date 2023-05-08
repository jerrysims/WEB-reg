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

  def edit 
    @form_action = :update
    @parent_agreement = current_parent.parent_agreement
  end

  def new
    @form_action = :create
    @parent_agreement = ParentAgreement.new
  end

  def update
    @parent_agreement = ParentAgreement.find params[:id]

    if @parent_agreement.update parent_agreement_params
      flash[:notice] = "Parent Agreement successfully updated"
      redirect_to root_path
    else 
      flash[:alert] = "Form could not be updated. Please ensure all required fields are completed"
      redirect_back fallback_location: edit_parent_parent_agreement_path(parent_id: @parent.id, id: @parent_agreement.id)
    end
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
      :signature
    )
  end

  def parent_params
    params.require(:parent_agreement).require(:parent).permit(:id, :first_name, :last_name)
  end
end
