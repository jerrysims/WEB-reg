FactoryBot.define do
  factory :product do
    name { "Product #{Faker::Number.unique.number(digits: 3)}" }
    unit_price { 50 }
    product_type { "fee" }
  end
end
