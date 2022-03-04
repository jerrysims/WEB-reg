class AddSecondaryEmailToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :secondary_email, :string
  end
end
