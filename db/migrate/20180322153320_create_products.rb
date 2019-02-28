class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :name
      t.integer :unit_price 
      t.timestamps null: false
    end
  end
end
