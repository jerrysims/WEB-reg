class AddIndexToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_index :registrations, [:student_id, :section_id], unique: true
  end
end
