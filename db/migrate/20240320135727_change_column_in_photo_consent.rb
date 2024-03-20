class ChangeColumnInPhotoConsent < ActiveRecord::Migration[6.0]
  def change
    change_column :photo_consents, :permission_and_consent, :string
  end
end
