class AddWebEmailToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :web_email, :string
  end
end
