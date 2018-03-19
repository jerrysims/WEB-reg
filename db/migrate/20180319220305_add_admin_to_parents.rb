class AddAdminToParents < ActiveRecord::Migration
  def change
    add_column :parents, :admin, :boolean, default: false
  end
end
