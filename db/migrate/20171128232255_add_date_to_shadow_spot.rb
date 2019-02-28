class AddDateToShadowSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :shadow_spots, :date, :datetime
  end
end
