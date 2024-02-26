class AddTimestampsToTeachersSection < ActiveRecord::Migration[6.0]
  def change_table
    add_column :teachers_sections, :created_at, :datetime, null: false
    add_column :teachers_sections, :updated_at, :datetime, null: false
  end
end
