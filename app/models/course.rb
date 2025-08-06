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
    "Study Hall", 
    "World Languages"
  ]

  DIVISIONS = ["MS", "HS", "MS/HS"]

  has_many :course_corequisites
  has_many :corequisites, through: :course_corequisites
  has_many :sections, dependent: :destroy
  has_many :registrations, through: :sections
  has_many :students, through: :registrations
  belongs_to :registration_period
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: { scope: :registration_period_id }
  validates :grades, presence: true
  validates :division, inclusion: { in: DIVISIONS }

  scope :extracurricular, ->{ select{ |c| c.rp_type == "extracurricular" } }
  scope :academic, ->{ select{ |c| c.rp_type == "academic" } }

  delegate :rp_type, to: :registration_period
  delegate :semester, to: :registration_period

  def fee
    products.fees.empty? ? 0 : products.fees.first.unit_price
  end

  def fee_product
    products.find_by(product_type: "fee")
  end

  def semester_tuition
    return Product.study_hall_tuition_semester(registration_period).unit_price if name == "Study Hall"
    return Product.extracurricular_tuition_semester(registration_period).unit_price if subject_area == "Extracurricular"
    return Product.band_choir_theater_yearbook_tuition_semester(registration_period).unit_price if ["Performance Art", "Elective - Yearbook"].include?(subject_area)

    tuition_method = case division
                     when "MS", "MS/HS"
                       twice_weekly ? :middle_school_tuition_twice_weekly_semester : :middle_school_tuition_semester
                     when "HS"
                       twice_weekly ? :high_school_tuition_twice_weekly_semester : :high_school_tuition_semester
                     end

    Product.send(tuition_method, registration_period).unit_price
  end
end
