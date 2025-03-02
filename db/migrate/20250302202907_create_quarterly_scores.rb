class CreateQuarterlyScores < ActiveRecord::Migration[6.0]
  def change
    create_table :quarterly_scores do |t|
      t.references :registration, null: false, foreign_key: true
      t.integer :quarter
      t.string :grade

      t.timestamps
    end
  end
end
