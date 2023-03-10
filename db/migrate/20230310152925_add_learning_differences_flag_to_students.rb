class AddLearningDifferencesFlagToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :learning_differences_flag, :boolean
  end
end
