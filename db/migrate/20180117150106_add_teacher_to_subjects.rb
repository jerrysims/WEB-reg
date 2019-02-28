class AddTeacherToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :subjects, :teacher, index: true, foreign_key: true
  end
end
