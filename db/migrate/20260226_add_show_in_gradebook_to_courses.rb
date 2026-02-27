class AddShowInGradebookToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :show_in_gradebook, :boolean, default: true, null: false
  end
end
