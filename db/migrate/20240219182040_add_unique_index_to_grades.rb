class AddUniqueIndexToGrades < ActiveRecord::Migration[6.0]
  def change
    add_index :grades, [:section, :student], unique: true
  end
end
