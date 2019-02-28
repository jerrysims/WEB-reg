class AddLunchToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :lunch, :boolean, default: false
  end
end
