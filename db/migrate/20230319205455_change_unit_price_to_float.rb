class ChangeUnitPriceToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :unit_price, :float
  end
end
