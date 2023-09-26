class AddGradesToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :q1_grade, :text
    add_column :registrations, :q2_grade, :text
    add_column :registrations, :q3_grade, :text
    add_column :registrations, :q4_grade, :text
  end
end
