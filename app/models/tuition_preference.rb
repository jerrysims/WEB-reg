class TuitionPreference < ApplicationRecord
  belongs_to :parent
  belongs_to :registration_period

  validates_presence_of :frequency
  validates_presence_of :payment_method
  validates :parent, uniqueness: { scope: :registration_period_id }
end
