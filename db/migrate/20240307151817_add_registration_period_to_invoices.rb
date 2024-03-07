class AddRegistrationPeriodToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoices, :registration_period, foreign_key: true
  end
end
