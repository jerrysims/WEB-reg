class CreateStudentShadows < ActiveRecord::Migration
  def change
    create_table :student_shadows do |t|
      t.references :student, index: true, foreign_key: true
      t.references :shadow_spot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
