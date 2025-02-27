class AddActionToRegistrationLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :registration_logs, :action, :string
  end
end
