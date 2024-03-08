class RemoveVolunteerBuyoutFromParentAgreements < ActiveRecord::Migration[6.0]
  def change
    remove_column :parent_agreements, :volunteer_buyout, :boolean
  end
end
