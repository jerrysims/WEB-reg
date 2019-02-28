class AddStatusToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :status, :string, default: "selected"
  end
end
