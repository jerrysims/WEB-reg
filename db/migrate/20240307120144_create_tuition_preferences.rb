class CreateTuitionPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :tuition_preferences do |t|
      t.references :parent, null: false, foreign_key: true
      t.references :registration_period, null: false, foreign_key: true
      t.string :frequency
      t.string :payment_method

      t.timestamps
    end
  end
end
