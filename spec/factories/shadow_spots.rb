FactoryGirl.define do
  factory :shadow_spot do
    subject
    time "8:45 AM"
    date 2.weeks.from_now
  end
end
