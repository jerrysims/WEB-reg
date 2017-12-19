class CreateShadowSpots < ActiveRecord::Migration
  def change
    create_table :shadow_spots do |t|
      t.datetime :slot
      t.integer :grade

      t.timestamps null: false
    end
  end
end
