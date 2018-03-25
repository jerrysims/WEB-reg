class Product < ActiveRecord::Base
  DONATION = Product.find_by(name: "Scholarship Donation")
  REGISTRATION_FEE = Product.find_by(name: "2018/2019 Registration")
  TUITION = {
    annual: Product.find_by(name: "2018/2019 Class Tuition-Annual"),
    semester: Product.find_by(name: "2018/2019 Class Tuition-Semester"),
    monthly: Product.find_by(name: "2018/2019 Class Tuition-Monthly")
  }
  STUDY_HALL = {
    semester: Product.find_by(name: "2018/2019 Study Hall-Semester"),
    monthly: Product.find_by(name: "2018/2019 Study Hall - Monthly")
  }
  FAMILY_DISCOUNT = Product.find_by(name: "Family Registration Discount")


  has_and_belongs_to_many :courses

  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: PRODUCT_TYPES

end
