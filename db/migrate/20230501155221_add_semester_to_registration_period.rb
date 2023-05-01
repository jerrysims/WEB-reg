class AddSemesterToRegistrationPeriod < ActiveRecord::Migration[6.0]
  def change
    add_column :registration_periods, :semester, :string
  end
end
