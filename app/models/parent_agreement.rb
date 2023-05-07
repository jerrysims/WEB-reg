class ParentAgreement < ApplicationRecord
  belongs_to :parent

  def status
    return "complete" if agree_to_pay && 
                         late_fee_acknowledgment && 
                         no_refund_on_voluntary_withdraw && 
                         prorate_on_requested_withdraw && 
                         (plan_to_volunteer || volunteer_buyout) && 
                         late_fee_for_late_pickup && 
                         signature

    "incomplete"
  end
end
