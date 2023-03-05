FactoryBot.define do
  factory :parent_agreement do
    agree_to_pay { false }
    late_fee_acknowledgment { false }
    no_refund_on_voluntary_withdraw { false }
    prorate_on_requested_withdraw { false }
    plan_to_volunteer { false }
    volunteer_buyout { false }
    late_fee_for_late_pickup { "" }
    parent { nil }
  end
end
