class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.integer :student_id
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
