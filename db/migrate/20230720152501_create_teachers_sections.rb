class CreateTeachersSections < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers_sections do |t|
      t.belongs_to :teacher
      t.belongs_to :section
    end
  end
end
