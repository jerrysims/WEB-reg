class AddDivisionToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :division, :string
    add_column :courses, :twice_weekly, :boolean
  end
end
