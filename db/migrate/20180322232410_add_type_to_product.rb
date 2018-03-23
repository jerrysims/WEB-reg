class AddTypeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :product_type, :text
  end
end
