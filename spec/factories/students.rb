FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { 13.years.ago }
    grade { 5 }
    parent { create(:parent) }
    emergency_phone { Faker::Number.number digits: 10 }
    emergency_contact { Faker::Name.full_name }
  end

  trait :incomplete do
    emergency_phone { nil }
    emergency_contact { nil }
  end

end
