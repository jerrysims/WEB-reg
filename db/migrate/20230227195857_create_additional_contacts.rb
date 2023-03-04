class CreateAdditionalContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :additional_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
