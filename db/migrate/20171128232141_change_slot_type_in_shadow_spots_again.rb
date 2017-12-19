class ChangeSlotTypeInShadowSpotsAgain < ActiveRecord::Migration
  def change
    change_column :shadow_spots, :slot, :text
  end
end
