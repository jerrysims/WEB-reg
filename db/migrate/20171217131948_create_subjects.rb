class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.text :name
      t.integer :grade

      t.timestamps null: false
    end
  end
end
