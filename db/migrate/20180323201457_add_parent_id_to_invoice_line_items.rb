class AddParentIdToInvoiceLineItems < ActiveRecord::Migration
  def change
    add_column :invoice_line_items, :parent_id, :integer
  end
end
