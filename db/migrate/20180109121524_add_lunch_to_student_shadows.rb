class AddLunchToStudentShadows < ActiveRecord::Migration
  def change
    add_column :student_shadows, :lunch, :boolean, default: false
  end
end
