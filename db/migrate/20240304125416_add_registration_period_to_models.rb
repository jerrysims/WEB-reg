class AddRegistrationPeriodToModels < ActiveRecord::Migration[6.0]
  def change
    tables = %i[release_of_liabilities photo_consents parent_agreements medical_forms]

    tables.each do |table|
      add_reference table, :registration_period, foreign_key: true
    end
  end
end
