class AddTypeToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_type, :text
  end
end
