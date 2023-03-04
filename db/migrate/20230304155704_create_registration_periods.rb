class CreateRegistrationPeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :registration_periods do |t|
      t.string :name
      t.date :open_date
      t.date :close_date

      t.timestamps
    end
  end
end
