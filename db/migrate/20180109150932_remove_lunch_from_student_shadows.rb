class RemoveLunchFromStudentShadows < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_shadows, :lunch
  end
end
