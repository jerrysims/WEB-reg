class AddSuggestedGradeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :suggested_grade, :text
    add_column :courses, :subject_area, :text
  end
end
