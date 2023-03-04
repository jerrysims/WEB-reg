class AddStudentCountToSections < ActiveRecord::Migration[6.0]
  def up
    add_column :sections, :students_count, :integer, default: 0, null: false
    Section.reset_column_information
    Section.all.each do |s|
      Section.update_counters s.id, students_count: s.students.count
    end
  end
  def down
    remove_column :sections, :students_count
  end
end