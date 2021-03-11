class AddNicknameToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :nickname, :string
  end
end
