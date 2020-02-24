class AddConfirmedGradeToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :confirmed_grade, :boolean, default: true
  end
end
