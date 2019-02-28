class AddStudentEmailToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :student_email, :text
  end
end
