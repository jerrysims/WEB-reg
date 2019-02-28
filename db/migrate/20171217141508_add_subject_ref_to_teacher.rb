class AddSubjectRefToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_reference :teachers, :subject
  end
end
