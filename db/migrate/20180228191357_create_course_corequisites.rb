class CreateCourseCorequisites < ActiveRecord::Migration[5.2]
  def change
    create_table :course_corequisites do |t|
      t.integer :course_id
      t.integer :corequisite_id
    end
  end
end
