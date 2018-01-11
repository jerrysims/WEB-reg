class RemoveParentColumnsFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :parent_first_name
    remove_column :students, :parent_last_name
    remove_column :students, :email_address
  end
end
