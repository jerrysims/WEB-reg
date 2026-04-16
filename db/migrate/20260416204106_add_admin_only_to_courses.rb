class AddAdminOnlyToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :admin_only, :boolean, default: false, null: false
  end
end
