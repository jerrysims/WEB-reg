class RemoveIsAdminFromParents < ActiveRecord::Migration[6.0]
  def change
    remove_column :parents, :is_admin, :boolean
    remove_column :parents, :admin, :boolean
  end
end
