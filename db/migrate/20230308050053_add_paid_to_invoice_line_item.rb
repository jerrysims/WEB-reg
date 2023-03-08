class AddPaidToInvoiceLineItem < ActiveRecord::Migration[6.0]
  def change
    add_column :invoice_line_items, :paid, :boolean
  end
end
