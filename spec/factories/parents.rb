FactoryBot.define do
  factory :parent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::Number.number digits: 10 }
    password { 'password' }
    email { Faker::Internet.email }
    street_address_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip }
  end
end
