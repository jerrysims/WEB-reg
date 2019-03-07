class AddClosedToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :closed, :boolean, default: false
  end
end
