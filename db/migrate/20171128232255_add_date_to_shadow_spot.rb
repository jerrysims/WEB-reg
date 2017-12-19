class AddDateToShadowSpot < ActiveRecord::Migration
  def change
    add_column :shadow_spots, :date, :datetime
  end
end
