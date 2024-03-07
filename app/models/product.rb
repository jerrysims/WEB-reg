class Product < ActiveRecord::Base

  PRODUCT_TYPES = %w(fee study donation tuition registration extracurricular)

  belongs_to :registration_period
  has_and_belongs_to_many :courses

  validates :name, uniqueness: { scope: :registration_period_id }
  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: PRODUCT_TYPES

  scope :fees, -> { where(product_type: "fee") }
  scope :tuition, -> { where(product_type: "tuition") }
end
