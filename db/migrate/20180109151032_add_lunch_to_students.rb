class AddLunchToStudents < ActiveRecord::Migration
  def change
    add_column :students, :lunch, :boolean, default: false
  end
end
