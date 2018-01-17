class AddTeacherToSubjects < ActiveRecord::Migration
  def change
    add_reference :subjects, :teacher, index: true, foreign_key: true
  end
end
