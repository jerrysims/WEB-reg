class Course < ActiveRecord::Base
  SUBJECT_AREAS = [
    "Art",
    "Art/Science",
    "Elective",
    "Foreign Language",
    "Language Arts",
    "Math",
    "Science",
    "Social Studies",
    "Study Hall"
  ]

  has_many :course_corequisites
  has_many :corequisites, through: :course_corequisites
  has_many :sections, dependent: :destroy
  has_many :registrations
  has_many :students, through: :registrations
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true
  validates :grades, presence: true


  def fee
    products.empty? ? 0 : products.first.unit_price
  end

  def fee_product
    products.find_by(product_type: "fee")
  end

end
