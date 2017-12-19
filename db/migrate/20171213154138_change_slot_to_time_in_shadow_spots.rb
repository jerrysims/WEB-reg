class ChangeSlotToTimeInShadowSpots < ActiveRecord::Migration
  def change
    rename_column :shadow_spots, :slot, :time
  end
end
