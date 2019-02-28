class RemoveGradeFromShadowSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :shadow_spots, :grade
  end
end
