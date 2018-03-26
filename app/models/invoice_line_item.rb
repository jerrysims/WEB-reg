class InvoiceLineItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product
  belongs_to :parent

  validates :quantity, numericality: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :product
  validates_presence_of :parent
  validates_presence_of :quantity

  def to_invoice_array
    student = Student.find_by(id: student_id)
    product_name = Product.find_by(id: product_id)

    [
      id,
      student.present? ? student.full_name : "",
      parent.full_name,
      parent.street_address_1,
      parent.street_address_2,
      parent.city,
      parent.zip_code,
      parent.state,
      parent.email,
      product_id,
      product_name.nil? ? "" : product_name,
      quantity,
      product_name.nil? ? "" : product.unit_price
    ]
  end
end
