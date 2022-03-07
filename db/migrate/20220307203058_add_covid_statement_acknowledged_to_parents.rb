class AddCovidStatementAcknowledgedToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :covid_statement_acknowledged, :boolean
  end
end
