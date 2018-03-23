class Product < ActiveRecord::Base
  has_and_belongs_to_many :courses

  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: %w( registration tuition fee study)

end
