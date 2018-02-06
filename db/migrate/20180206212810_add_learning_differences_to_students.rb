class AddLearningDifferencesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :learning_differences, :text
  end
end
