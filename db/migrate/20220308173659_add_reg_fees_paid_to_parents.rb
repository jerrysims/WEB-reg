class AddRegFeesPaidToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :reg_fees_paid, :boolean
  end
end
