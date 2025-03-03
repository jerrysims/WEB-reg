class AddPublishedToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :published, :boolean
  end
end
