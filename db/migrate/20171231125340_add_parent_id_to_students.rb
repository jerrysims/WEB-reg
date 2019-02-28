class AddParentIdToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :parent, foreign_key: true
  end
end
