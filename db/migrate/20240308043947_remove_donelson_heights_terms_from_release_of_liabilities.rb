class RemoveDonelsonHeightsTermsFromReleaseOfLiabilities < ActiveRecord::Migration[6.0]
  def change
    remove_column :release_of_liabilities, :donelson_heights_terms, :boolean
  end
end
