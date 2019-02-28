class AddSubjectRefToShadowSpots < ActiveRecord::Migration[5.2]
  def change
    add_reference :shadow_spots, :subject
  end
end
