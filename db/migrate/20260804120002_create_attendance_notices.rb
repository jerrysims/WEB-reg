class CreateAttendanceNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_notices do |t|
      t.references :student, null: false, foreign_key: true
      t.references :school_day, null: false, foreign_key: true
      t.string :kind, null: false
      t.string :status, null: false, default: 'pending'
      t.text :notes

      t.timestamps null: false
    end

    add_index :attendance_notices, [:student_id, :school_day_id], unique: true
  end
end
