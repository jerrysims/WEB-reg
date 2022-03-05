class AddCurrentUserToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_reference :registrations, :user, foreign_key: { to_table: :parents }
  end
end
