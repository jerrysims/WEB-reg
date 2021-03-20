class ChangeCourseToSectionInRegistrations < ActiveRecord::Migration[5.2]
  def change
    remove_column :registrations, :course_id
    add_reference :registrations, :section, foreign_key: true
  end
end
