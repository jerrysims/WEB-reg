class RemoveLunchFromStudentShadows < ActiveRecord::Migration
  def change
    remove_column :student_shadows, :lunch
  end
end
