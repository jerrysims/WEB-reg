FactoryBot.define do
  factory :tuition_preference do
    parent { nil }
    registration_period { nil }
    frequency { "MyString" }
    payment_method { "MyString" }
  end
end
