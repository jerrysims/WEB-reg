class ChangeEmergencyNameToStringInStudents < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :emergency_contact, :string
    change_column :students, :emergency_phone, :string
  end
end
