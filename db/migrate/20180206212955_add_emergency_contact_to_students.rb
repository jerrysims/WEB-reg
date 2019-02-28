class AddEmergencyContactToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :emergency_contact, :text
    add_column :students, :emergency_phone, :text
  end
end
