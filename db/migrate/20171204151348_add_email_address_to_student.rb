class AddEmailAddressToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :email_address, :text
  end
end
