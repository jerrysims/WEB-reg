class RemovePublishedFromSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :published, :boolean
  end
end
