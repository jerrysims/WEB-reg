FactoryBot.define do
  factory :subject do
    name { ('a'..'z').to_a.shuffle.join }
    grade { 5 }
  end

end
