class CreateReceipt < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :form_name
      t.integer :parent_id
    end
  end
end
