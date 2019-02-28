class RemoveShadowSpotFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :shadow_spot_id
  end
end
