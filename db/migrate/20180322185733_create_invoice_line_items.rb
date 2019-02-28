class CreateInvoiceLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_line_items do |t|
      t.integer :student_id
      t.integer :product_id
      t.integer :quantity
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
