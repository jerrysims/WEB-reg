class AddTypeToParents < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :type, :string
  end
end
