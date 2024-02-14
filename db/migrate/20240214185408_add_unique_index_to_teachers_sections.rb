class AddUniqueIndexToTeachersSections < ActiveRecord::Migration[6.0]
  def change
    add_index :teachers_sections, [:section_id, :teacher_id], unique: true
  end
end
