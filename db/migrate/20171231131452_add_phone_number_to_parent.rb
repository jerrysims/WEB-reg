class AddPhoneNumberToParent < ActiveRecord::Migration
  def change
    add_column :parents, :phone_number, :string, limit: 10
  end
end
