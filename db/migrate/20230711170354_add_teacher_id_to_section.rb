class AddTeacherIdToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :teacher_id, :integer
  end
end
