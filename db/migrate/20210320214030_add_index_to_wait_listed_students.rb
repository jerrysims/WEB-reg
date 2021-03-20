class AddIndexToWaitListedStudents < ActiveRecord::Migration[5.2]
  def change
    add_index :wait_listed_students, [:student_id, :section_id], unique: true
  end
end
