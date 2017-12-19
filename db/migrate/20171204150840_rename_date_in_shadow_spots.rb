class RenameDateInShadowSpots < ActiveRecord::Migration
  def change
    rename_column :shadow_spots, :date, :shadow_date
  end
end
