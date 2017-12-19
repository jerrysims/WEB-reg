class AddSubjectRefToTeacher < ActiveRecord::Migration
  def change
    add_reference :teachers, :subject
  end
end
