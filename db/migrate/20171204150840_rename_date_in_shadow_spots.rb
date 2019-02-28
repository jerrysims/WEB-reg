class RenameDateInShadowSpots < ActiveRecord::Migration[5.2]
  def change
    rename_column :shadow_spots, :date, :shadow_date
  end
end
