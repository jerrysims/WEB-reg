class AddSubjectToShadowSpot < ActiveRecord::Migration
  def change
    add_column :shadow_spots, :subject, :text
  end
end
