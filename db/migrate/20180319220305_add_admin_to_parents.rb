class AddAdminToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :admin, :boolean, default: false
  end
end
