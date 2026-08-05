FactoryBot.define do
  factory :course do
    association :registration_period
    name { Faker::Educator.course_name }
    description { "Test Course Description" }
    textbooks { "MyText" }
    grades { "5,6,7,8" }
    suggested_grade { 6 }
    subject_area { Faker::Educator.subject }
    division { Course::DIVISIONS.sample }
  end
end
