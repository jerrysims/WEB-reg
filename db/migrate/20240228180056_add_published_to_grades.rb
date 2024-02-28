class AddPublishedToGrades < ActiveRecord::Migration[6.0]
  def change
    add_column :grades, :published, :boolean
  end
end
