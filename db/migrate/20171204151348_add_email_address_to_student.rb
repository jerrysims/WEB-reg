class AddEmailAddressToStudent < ActiveRecord::Migration
  def change
    add_column :students, :email_address, :text
  end
end
