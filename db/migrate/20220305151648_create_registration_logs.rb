class CreateRegistrationLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_logs do |t|
      t.references :student, foreign_key: true
      t.references :section, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: {to_table: :parents}
      t.string :previous_status
      t.string :new_status
      t.datetime :changed_at

      t.timestamps
    end
  end
end
