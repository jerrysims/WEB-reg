class Product < ActiveRecord::Base
  DONATION = Product.find_by(name: "Scholarship Donation")
  REGISTRATION_FEE = Product.find_by(name: "Registration Fee")
  REGISTRATION_FEE_1_CLASS = Product.find_by(name: "Registration Fee - one class")
  REGISTRATION_FEE_2_CLASSES = Product.find_by(name: "Registration Fee - two classes")
  ADMINISTRATIVE_FEE = Product.find_by(name: "Administrative Fee")
  MIDDLE_SCHOOL_TUITION = {
    semester: Product.find_by(name: "Middle School Tuition - Semester"),
    monthly: Product.find_by(name: "Middle School Tuition - Monthly")
  }
  MIDDLE_SCHOOL_TUITION_TWICE_WEEKLY = {
    semester: Product.find_by(name: "Middle School Tuition Twice Weekly - Semester"),
    monthly: Product.find_by(name: "Middle School Tuition Twice Weekly - Monthly")
  }
  HIGH_SCHOOL_TUITION = {
    semester: Product.find_by(name: "High School Tuition - Semester"),
    monthly: Product.find_by(name: "High School Tuition - Monthly")
  }
  HIGH_SCHOOL_TUITION_TWICE_WEEKLY = {
    semester: Product.find_by(name: "High School Tuition Twice Weekly - Semester"),
    monthly: Product.find_by(name: "High School Tuition Twice Weekly - Monthly")
  }
  STUDY_HALL_TUITION = {
    semester: Product.find_by(name: "Study Hall Tuition - Semester"),
    monthly: Product.find_by(name: "Study Hall Tuition - Monthly"),
  }
  MATH_CLASS_TUITION = {
    semester: Product.find_by(name: "Math Class Tuition - Semester"),
    monthly: Product.find_by(name: "Math Class Tuition - Monthly")
  }
  HIGH_SCHOOL_LANGUAGE_TUITION = {
    semester: Product.find_by(name: "High School Language Tuition - Semester"),
    monthly: Product.find_by(name: "High School Language Tuition - Monthly")
  }
  SIBLING_DISCOUNT = Product.find_by(name: "Sibling Discount")
  DROPPED_COURSE_FEE = Product.find_by(name: "Dropped Course Fee")
  DROPPED_TUITION_FEE = Product.find_by(name: "Dropped Tuition Fee")
  EXTRACURRICULAR_TUITION = Product.find_by(name: "Extracurricular Tuition")

  has_and_belongs_to_many :courses

  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: PRODUCT_TYPES

  scope :fees, -> { where(product_type: "fee") }
  scope :tuition, -> { where(product_type: "tuition") }
end
