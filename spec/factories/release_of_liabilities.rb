FactoryBot.define do
  factory :release_of_liability do
    read_and_agreed { false }
    signature { "MyString" }
  end
end
