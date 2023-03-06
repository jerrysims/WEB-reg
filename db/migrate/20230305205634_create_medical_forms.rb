class CreateMedicalForms < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_forms do |t|
      t.string :parent2_first_name
      t.string :parent2_last_name
      t.string :parent2_phone
      t.string :emergency_contact_first_name
      t.string :emergency_contact_last_name
      t.string :emergency_contact_relationship
      t.text :known_allergies
      t.text :medical_needs_or_concerns
      t.text :current_medications
      t.string :physician_first_name
      t.string :physician_last_name
      t.string :physician_phone
      t.string :medical_insurance_provider
      t.string :medical_insurance_policy_number
      t.string :preferred_hospital
      t.boolean :pain_reliever_permission
      t.boolean :medical_care_consent
      t.string :signature
      t.belongs_to :student

      t.timestamps
    end
  end
end
