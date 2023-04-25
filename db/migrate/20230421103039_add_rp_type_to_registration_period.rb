class AddRpTypeToRegistrationPeriod < ActiveRecord::Migration[6.0]
  def change
    add_column :registration_periods, :rp_type, :string
  end
end
