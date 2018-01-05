class RemoveShadowSpotFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :shadow_spot_id
  end
end
