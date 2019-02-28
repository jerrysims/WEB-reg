class AddLockedToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :locked, :boolean, default: false
  end
end
