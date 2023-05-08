class ChangePlanToVolunteerToString < ActiveRecord::Migration[6.0]
  def change
    change_column :parent_agreements, :plan_to_volunteer, :string
  end
end
