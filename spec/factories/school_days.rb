FactoryBot.define do
  factory :school_day do
    date { Date.current }
    day_name { date.strftime('%A') }
    active { true }
  end
end
