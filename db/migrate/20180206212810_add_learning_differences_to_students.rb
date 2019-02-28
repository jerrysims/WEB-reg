class AddLearningDifferencesToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :learning_differences, :text
  end
end
