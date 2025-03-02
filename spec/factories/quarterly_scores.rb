FactoryBot.define do
  factory :quarterly_score do
    registration { nil }
    quarter { 1 }
    grade { "MyString" }
  end
end
