FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { "Test Course Description" }
    textbooks { "MyText" }
    grades { "MyText" }
    suggested_grade { 6 }
    subject_area { Faker::Educator.subject }
  end

end
