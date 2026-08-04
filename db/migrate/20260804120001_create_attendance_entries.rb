class CreateAttendanceEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_entries do |t|
      t.references :student, null: false, foreign_key: true
      t.references :school_day, null: false, foreign_key: true
      t.string :status, null: false, default: 'not_yet_reported'
      t.text :notes

      t.timestamps null: false
    end

    add_index :attendance_entries, [:student_id, :school_day_id], unique: true
  end
end
