class RemoveGradeFromShadowSpots < ActiveRecord::Migration
  def change
    remove_column :shadow_spots, :grade
  end
end
