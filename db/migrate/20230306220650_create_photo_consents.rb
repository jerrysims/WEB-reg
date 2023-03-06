class CreatePhotoConsents < ActiveRecord::Migration[6.0]
  def change
    create_table :photo_consents do |t|
      t.boolean :permission_and_consent
      t.string :signature

      t.timestamps
    end
  end
end
