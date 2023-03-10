class CreateLearningDifferencesForms < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_differences_forms do |t|
      t.text :learning_differences
      t.text :successful_accomodations
      t.text :home_accomodations
      t.text :anything_else
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
