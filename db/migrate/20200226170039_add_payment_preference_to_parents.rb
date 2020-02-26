class AddPaymentPreferenceToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :payment_preference, :text
  end
end
