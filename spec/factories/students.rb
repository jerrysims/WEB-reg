FactoryGirl.define do
  factory :student do
    first_name "Ritchie"
    last_name "Valens"
    date_of_birth { 13.years.ago }
    grade 5
    parent
    emergency_phone '6156156155'
    emergency_contact 'Mary Doe'
  end
end
