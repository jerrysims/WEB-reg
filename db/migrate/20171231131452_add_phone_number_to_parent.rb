class AddPhoneNumberToParent < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :phone_number, :string, limit: 10
  end
end
