class AddUniqueIndexToGrades < ActiveRecord::Migration[6.0]
  def change
    add_index :grades, [:section_id, :student_id], unique: true
  end
end
