class RemoveSubjectFromShadowSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :shadow_spots, :subject
  end
end
