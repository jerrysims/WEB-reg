class AddTuitionToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :tuition, :float
  end
end
