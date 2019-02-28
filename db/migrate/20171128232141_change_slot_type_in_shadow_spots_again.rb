class ChangeSlotTypeInShadowSpotsAgain < ActiveRecord::Migration[5.2]
  def change
    change_column :shadow_spots, :slot, :text
  end
end
