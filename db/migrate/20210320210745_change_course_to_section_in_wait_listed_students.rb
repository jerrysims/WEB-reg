class ChangeCourseToSectionInWaitListedStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :wait_listed_students, :course_id
    add_reference :wait_listed_students, :section, foreign_key: true
  end
end
