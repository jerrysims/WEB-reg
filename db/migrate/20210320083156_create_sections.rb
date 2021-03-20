class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
      t.integer :class_minimum
      t.integer :class_maximum

      t.timestamps
    end

    remove_columns :courses, :day,
                             :start_time,
                             :end_time,
                             :class_minimum,
                             :class_maximum
  end
end
