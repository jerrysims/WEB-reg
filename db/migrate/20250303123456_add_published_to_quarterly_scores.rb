class AddPublishedToQuarterlyScores < ActiveRecord::Migration[6.0]
  def change
    add_column :quarterly_scores, :published, :boolean, default: false
  end
end
