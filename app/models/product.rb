class Product < ActiveRecord::Base
  DONATION = Product.find_by(name: "Scholarship Donation")
  REGISTRATION_FEE = Product.find_by(name: "Registration Fee")
  ADMINISTRATIVE_FEE = Product.find_by(name: "Administrative Fee")
  CLASS_TUITION = {
    annual: Product.find_by(name: "Class Tuition - Annual"),
    semester: Product.find_by(name: "Class Tuition - Semester"),
    monthly: Product.find_by(name: "Class Tuition - Monthly")
  }
  STUDY_HALL_TUITION = {
    semester: Product.find_by(name: "Study Hall Tuition - Semester"),
    monthly: Product.find_by(name: "Study Hall Tuition - Monthly"),
    annual: Product.find_by(name: "Study Hall Tuition - Annual")
  }
  MATH_CLASS_TUITION = {
    annual: Product.find_by(name: "Math Class Tuition - Annual"),
    semester: Product.find_by(name: "Math Class Tuition - Semester"),
    monthly: Product.find_by(name: "Math Class Tuition - Monthly")
  }
  SIBLING_DISCOUNT = Product.find_by(name: "Family Registration Discount")

  has_and_belongs_to_many :courses

  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: PRODUCT_TYPES

end
