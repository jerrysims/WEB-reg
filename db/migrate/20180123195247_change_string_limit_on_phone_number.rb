class ChangeStringLimitOnPhoneNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :parents, :phone_number, :string, limit: 16
  end
end
