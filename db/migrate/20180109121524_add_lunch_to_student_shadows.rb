class AddLunchToStudentShadows < ActiveRecord::Migration[5.2]
  def change
    add_column :student_shadows, :lunch, :boolean, default: false
  end
end
