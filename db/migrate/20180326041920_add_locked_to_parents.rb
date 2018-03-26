class AddLockedToParents < ActiveRecord::Migration
  def change
    add_column :parents, :locked, :boolean, default: false
  end
end
