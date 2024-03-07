class TuitionPreferencesController < ApplicationController
  before_action :set_rp

  def create
    @tuition_preference = TuitionPreference.create(tuition_preference_params)
    create_donation(@donation_total)

    redirect_to invoices_path(registration_period_id: @rp.id)
  end

  private
  def create_donation(donation_total)
    @invoice = Invoice.find_or_create_by(parent: current_parent)
    if @donation = Invoice.get_donation(current_parent)
      @donation.update_attributes(quantity: donation_total)
    else
      @donation = InvoiceLineItem.create(
        invoice: @invoice,
        product: Product.donation(@rp),
        quantity: donation_total,
        parent: current_parent
      )
    end
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:tuition_preference][:registration_period_id])
  end

  def tuition_preference_params
    params.require(:tuition_preference).permit(:parent_id, :registration_period_id, :frequency, :payment_method)
  end

  def donation_total
    params.require(:tuition_preference).require(:donation).permit(:quantity)
  end
end
