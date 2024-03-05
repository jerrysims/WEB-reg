class AddStatusToRegistrationPeriods < ActiveRecord::Migration[6.0]
  def change
    add_column :registration_periods, :status, :string, default: "future"
  end
end
