class RevertDateInShadowSpots < ActiveRecord::Migration[5.2]
  def change
    rename_column :shadow_spots, :shadow_date, :date
  end
end
