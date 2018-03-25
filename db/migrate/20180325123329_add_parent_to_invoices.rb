class AddParentToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :parent, index: true, foreign_key: true
  end
end
