class AddParentToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :parent, index: true, foreign_key: true
  end
end
