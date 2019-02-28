class AddSubjectToShadowSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :shadow_spots, :subject, :text
  end
end
