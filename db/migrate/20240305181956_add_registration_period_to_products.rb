class AddRegistrationPeriodToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :registration_period, foreign_key: true
  end
end
