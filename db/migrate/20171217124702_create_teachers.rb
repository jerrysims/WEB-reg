class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.text :first_name
      t.text :last_name
      t.text :email

      t.timestamps null: false
    end
  end
end
