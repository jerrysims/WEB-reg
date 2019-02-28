class ChangeSlotToTimeInShadowSpots < ActiveRecord::Migration[5.2]
  def change
    rename_column :shadow_spots, :slot, :time
  end
end
