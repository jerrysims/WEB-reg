class AddAddressToParent < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :street_address_1, :text
    add_column :parents, :street_address_2, :text
    add_column :parents, :city, :text
    add_column :parents, :state, :text
    add_column :parents, :zip_code, :text
  end
end
