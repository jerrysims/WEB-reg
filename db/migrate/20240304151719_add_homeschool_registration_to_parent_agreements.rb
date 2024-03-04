class AddHomeschoolRegistrationToParentAgreements < ActiveRecord::Migration[6.0]
  def change
    add_column :parent_agreements, :homeschool_registration, :boolean
  end
end
