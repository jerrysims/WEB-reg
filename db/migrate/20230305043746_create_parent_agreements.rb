class CreateParentAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :parent_agreements do |t|
      t.boolean :agree_to_pay
      t.boolean :late_fee_acknowledgment
      t.boolean :no_refund_on_voluntary_withdraw
      t.boolean :prorate_on_requested_withdraw
      t.boolean :plan_to_volunteer
      t.boolean :volunteer_buyout
      t.boolean :late_fee_for_late_pickup
      t.string :signature
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
