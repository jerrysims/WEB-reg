FactoryBot.define do
  factory :parent do
    first_name { "Buddy" }
    last_name { "Holly" }
    phone_number { "6156156156" }
    password { 'password' }
    email { 'test@testy.com' }
    street_address_1 { '123 Any Ave.' }
    city { 'Nashville' }
    state { 'TN' }
    zip_code { '37206' }
  end
end
