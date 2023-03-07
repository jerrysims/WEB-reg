class AddBelongsToParentToPhotoConsents < ActiveRecord::Migration[6.0]
  def change
    add_reference :photo_consents, :parent, null: false, foreign_key: true
  end
end
