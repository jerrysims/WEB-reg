class AddRegistrationPeriodToInvoiceLineItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoice_line_items, :registration_period, foreign_key: true
  end
end
