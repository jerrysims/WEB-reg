class ChangeStudentEmailToStringInStudents < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :student_email, :string
  end
end
