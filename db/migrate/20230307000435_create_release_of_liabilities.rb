class CreateReleaseOfLiabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :release_of_liabilities do |t|
      t.boolean :waiver_terms
      t.boolean :dalewood_terms
      t.string :signature
      t.belongs_to :parent

      t.timestamps
    end
  end
end
