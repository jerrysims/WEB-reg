class RemoveTuitionPreferenceFromParents < ActiveRecord::Migration[6.0]
  def change
    remove_column :parents, :tuition_preference, :string
    remove_column :parents, :payment_preference, :string
  end
end
