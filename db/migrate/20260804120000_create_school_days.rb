class CreateSchoolDays < ActiveRecord::Migration[6.0]
  def change
    create_table :school_days do |t|
      t.date :date, null: false
      t.string :day_name, null: false
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end

    add_index :school_days, :date, unique: true
  end
end
