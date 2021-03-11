class AddPronounsAndRaceToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :race, :string
    add_column :students, :pronouns, :string
  end
end
