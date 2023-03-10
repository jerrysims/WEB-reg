FactoryBot.define do
  factory :learning_differences_form do
    learning_differences { "MyText" }
    successful_accomodations { "MyText" }
    home_accomodations { "MyText" }
    anything_else { "MyText" }
    student { nil }
  end
end
