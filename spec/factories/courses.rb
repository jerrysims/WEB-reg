FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { "Test Course Description" }
    textbooks { "MyText" }
    grades { "MyText" }
    suggested_grade { 6 }
    subject_area { Faker::Educator.subject }
    division { suggested_grade <= 8 ? "MS" : "HS" }
    registration_period_id {1}

    trait :ms_hs do
      division { "MS/HS" }
    end
  end
end
