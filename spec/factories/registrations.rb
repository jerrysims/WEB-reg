FactoryBot.define do
  factory :registration do
    student
    section
    user { student.parent }
  end
end
