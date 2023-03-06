FactoryBot.define do
  factory :medical_form do
    parent2_first_name { "MyString" }
    parent2_last_name { "MyString" }
    parent2_phone { "MyString" }
    emergency_contact_first_name { "MyString" }
    emergency_contact_last_name { "MyString" }
    emergency_contact_relationship { "MyString" }
    known_allergies { "MyText" }
    medical_needs_or_concerns { "MyText" }
    current_medications { "MyText" }
    physician_first_name { "MyString" }
    physician_last_name { "MyString" }
    physician_phone { "MyString" }
    medical_insurance_provider { "MyString" }
    medical_insurance_policy_number { "MyString" }
    preferred_hospital { "MyString" }
    pain_reliever_permission { false }
    medical_care_consent { false }
    signature { "MyString" }
  end
end
