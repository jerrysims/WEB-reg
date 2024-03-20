class AddRegistrationPeriodAndParentToMedicalForms < ActiveRecord::Migration[6.0]
  def change
    add_reference :medical_forms, :parent, foreign_key: true
  end
end
