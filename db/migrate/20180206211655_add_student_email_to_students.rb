class AddStudentEmailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_email, :text
  end
end
