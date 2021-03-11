FactoryBot.define do
  factory :student do
    date_of_birth { 13.years.ago }
    emergency_contact { Faker::Name.name }
    emergency_phone { Faker::Number.number digits: 10 }
    first_name { Faker::Name.first_name }
    grade { 5 }
    last_name { Faker::Name.last_name }
    parent { create(:parent) }
    pronouns { Student::PRONOUN_OPTIONS.sample }
    race { Student::RACE_OPTIONS.sample }
  end

  trait :incomplete do
    emergency_phone { nil }
    emergency_contact { nil }
  end

end
