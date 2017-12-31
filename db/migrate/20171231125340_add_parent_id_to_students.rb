class AddParentIdToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :parent, foreign_key: true
  end
end
