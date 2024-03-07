class Student < ActiveRecord::Base
  include StudentHelper

  belongs_to :parent
  has_many :registrations, dependent: :destroy
  has_many :sections, through: :registrations
  has_many :courses, through: :sections
  has_many :teachers, through: :sections
  has_many :wait_listed_students, dependent: :destroy
  has_one :medical_form
  has_one :learning_differences_form

  validates :date_of_birth, presence: true
  validates :emergency_contact, presence: true
  validates :emergency_phone, presence: true
  validates :first_name, presence: true
  validates :grade, presence: true
  validates :last_name, presence: true
  validates :parent, presence: true
  validates :pronouns, presence: true
  validates :race, presence: true

  attr_accessor :shadow_spot

  scope :missing_web_email, -> { where(web_email: nil) }
  scope :web_email_different_domain, -> { where.not("web_email LIKE ?", "%@webtutorialnashville.com") }
  scope :unconfirmed, -> { where(confirmed_grade: false) }
  scope :enrolled, -> (rp) { joins(registrations: { section: { course: :registration_period } }).where(courses: { registration_period_id: rp.id }) }

  DAYS_ORDER = %w(Tuesday Thursday)

  def available_courses(rp)
    Course.where(registration_period_id: rp.id).order(:name).select { |c| c.grades.split(',').include?(grade.to_s) }
  end

  def daily_schedule(day, registration_period)
    sections.joins(course: :registration_period).where(day: [day, "Tuesday/Thursday"], courses: { registration_period: registration_period }).distinct.order(:start_time)
  end

  def fl_course_count
    sections.where(day: "Tuesday/Thursday").select{ |s| s.course.subject_area == "Foreign Language" }.count
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def mailing_address
    "#{parent.street_address_1}, #{parent.street_address_2}, #{parent.city}, #{parent.state}, #{parent.zip_code}"
  end

  def math_course_count
    courses.where(subject_area: "Math").count
  end

  def needs_learning_differences_link
    learning_differences || learning_differences_flag 
  end

  def parents_full_name
    "#{parent.first_name.capitalize} #{parent.last_name.capitalize}"
  end

  def reg_fee(rp)
    case rp_courses(rp).count
    when 0
      nil
    when 1
      Product.registration_fee_1_class(rp)
    when 2
      Product.registration_fee_2_classes(rp)
    else
      Product.registration_fee_3_classes(rp)
    end
  end

  def rp_courses(rp)
    courses.where(registration_period_id: rp.id)
  end

  def should_be_offered_lunch?
    !shadow_spots.select { |ss| ss.time == "10:15 AM" }.empty?
  end
  
  def standard_course_count
    courses.count - math_course_count - study_hall_count - fl_course_count
  end

  def study_hall_count
    courses.select { |c| c.name.include? "Study Hall"}.count
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def wait_listed_sections
    wait_listed_students.map { |wls| wls.section }
  end

end
