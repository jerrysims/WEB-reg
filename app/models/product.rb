class Product < ActiveRecord::Base

  PRODUCT_TYPES = %w(fee study donation tuition registration extracurricular)

  belongs_to :registration_period
  has_and_belongs_to_many :courses

  validates :name, uniqueness: { scope: :registration_period_id }
  validates_presence_of :name
  validates_presence_of :unit_price
  validates_inclusion_of :product_type, in: PRODUCT_TYPES

  scope :fees, -> { where(product_type: "fee") }
  scope :registration_period, -> (rp) { where(registration_period_id: rp.id) }
  scope :tuition, -> { where(product_type: "tuition") }

  
  # class_methods 
  def self.donation(rp)
    registration_period(rp).find_by(name: "Scholarship Donation")
  end

  def self.registration_fee_1_class(rp)
    registration_period(rp).find_by(name: "Registration Fee - one class")
  end

  def self.registration_fee_2_classes(rp)
    registration_period(rp).find_by(name: "Registration Fee - two classes")
  end

  def self.registration_fee_3_classes(rp)
    registration_period(rp).find_by(name: "Registration Fee - three classes")
  end

  def self.administrative_fee(rp)
    registration_period(rp).find_by(name: "Administrative Fee")
  end

  def self.middle_school_tuition_semester(rp)
    registration_period(rp).find_by(name: "Middle School Tuition - Semester")
  end

  def self.middle_school_tuition_monthly(rp)
    registration_period(rp).find_by(name: "Middle School Tuition - Monthly")
  end

  def self.middle_school_tuition_twice_weekly_semester(rp)
    registration_period(rp).find_by(name: "Middle School Tuition Twice Weekly - Semester")
  end

  def self.middle_school_tuition_twice_weekly_monthly(rp)
    registration_period(rp).find_by(name: "Middle School Tuition Twice Weekly - Monthly")
  end

  def self.high_school_tuition_semester(rp)
    registration_period(rp).find_by(name: "High School Tuition - Semester")
  end

  def self.high_school_tuition_monthly(rp)
    registration_period(rp).find_by(name: "High School Tuition - Monthly")
  end

  def self.high_school_tuition_twice_weekly_semester(rp)
    registration_period(rp).find_by(name: "High School Tuition Twice Weekly - Semester")
  end

  def self.high_school_tuition_twice_weekly_monthly(rp)
    registration_period(rp).find_by(name: "High School Tuition Twice Weekly - Monthly")
  end

  def self.study_hall_tuition_semester(rp)
    registration_period(rp).find_by(name: "Study Hall Tuition - Semester")
  end

  def self.study_hall_tuition_monthly(rp)
    registration_period(rp).find_by(name: "Study Hall Tuition - Monthly")
  end

  def self.sibling_discount(rp)
    registration_period(rp).find_by(name: "Sibling Discount")
  end

  def self.extracurricular_tuition_semester(rp)
    registration_period(rp).find_by(name: "Extracurricular Tuition - Semester")
  end

  def self.extracurricular_tuition_monthly(rp)
    registration_period(rp).find_by(name: "Extracurricular Tuition - Monthly")
  end

  def self.band_choir_theater_yearbook_tuition_semester(rp)
    registration_period(rp).find_by(name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Semester")
  end

  def self.band_choir_theater_yearbook_tuition_monthly(rp)
    registration_period(rp).find_by(name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Monthly")
  end
end
