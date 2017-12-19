class RevertDateInShadowSpots < ActiveRecord::Migration
  def change
    rename_column :shadow_spots, :shadow_date, :date
  end
end
