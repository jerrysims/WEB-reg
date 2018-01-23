class ChangeStringLimitOnPhoneNumber < ActiveRecord::Migration
  def change
    change_column :parents, :phone_number, :string, limit: 16
  end
end
