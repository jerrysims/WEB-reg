class AddSubjectRefToShadowSpots < ActiveRecord::Migration
  def change
    add_reference :shadow_spots, :subject
  end
end
