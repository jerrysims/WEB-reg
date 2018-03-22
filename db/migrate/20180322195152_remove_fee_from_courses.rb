class RemoveFeeFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :fee
  end
end
