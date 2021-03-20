FactoryBot.define do
  factory :registration do
    association :student
    association :section
  end
end
