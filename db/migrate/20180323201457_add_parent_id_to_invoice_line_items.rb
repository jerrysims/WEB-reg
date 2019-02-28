class AddParentIdToInvoiceLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_line_items, :parent_id, :integer
  end
end
