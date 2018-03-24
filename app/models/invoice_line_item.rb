class InvoiceLineItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product
  belongs_to :parent

  validates :quantity, numericality: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :product
  validates_presence_of :parent
  validates_presence_of :quantity
end
