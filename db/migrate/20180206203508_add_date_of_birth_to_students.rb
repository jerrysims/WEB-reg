class AddDateOfBirthToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :date_of_birth, :date
  end
end
