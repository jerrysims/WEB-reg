class RenameDalewoodTermsToDonelsonHeightsTerms < ActiveRecord::Migration[6.0]
  def change
    rename_column :release_of_liabilities, :dalewood_terms, :donelson_heights_terms
  end
end
