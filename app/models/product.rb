class Product < ActiveRecord::Base
  has_and_belongs_to_many :courses

  validates_presence_of :name
  validates_presence_of :unit_price
end
