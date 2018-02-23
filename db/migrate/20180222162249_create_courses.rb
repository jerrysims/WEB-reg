class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :name
      t.text :description
      t.text :textbooks
      t.text :grades
      t.text :day
      t.time :start_time
      t.time :end_time
      t.integer :fee
      t.integer :class_minimum
      t.integer :class_maximum

      t.timestamps null: false
    end
  end
end
