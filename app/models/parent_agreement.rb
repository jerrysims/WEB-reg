class ParentAgreement < ApplicationRecord
  OPTIONS = %w(volunteer buyout)

  belongs_to :parent

  validates_presence_of :agree_to_pay,
                        :late_fee_acknowledgment,
                        :no_refund_on_voluntary_withdraw,
                        :prorate_on_requested_withdraw,
                        :plan_to_volunteer,
                        :late_fee_for_late_pickup,
                        :signature

  def status
    return "complete" if agree_to_pay && 
                         late_fee_acknowledgment && 
                         no_refund_on_voluntary_withdraw && 
                         prorate_on_requested_withdraw && 
                         plan_to_volunteer && 
                         late_fee_for_late_pickup && 
                         signature

    "incomplete"
  end
end
