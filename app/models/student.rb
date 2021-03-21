class Student < ActiveRecord::Base
  include StudentHelper

  belongs_to :parent
  has_many :student_shadows
  has_many :shadow_spots, through: :student_shadows
  has_many :registrations, dependent: :destroy
  has_many :sections, through: :registrations
  has_many :courses, through: :sections
  has_many :wait_listed_students, dependent: :destroy

  accepts_nested_attributes_for :student_shadows

  validates :date_of_birth, presence: true
  validates :emergency_contact, presence: true
  validates :emergency_phone, presence: true
  validates :first_name, presence: true
  validates :grade, presence: true
  validates :last_name, presence: true
  validates :parent, presence: true

  attr_accessor :shadow_spot

  scope :missing_web_email, -> { where(web_email: nil) }
  scope :unconfirmed, -> { where(confirmed_grade: nil) }

  DAYS_ORDER = %w(Tuesday Thursday)

  def available_courses
    Course.all.select { |c| c.grades.split(',').include?(grade.to_s) }
  end

  def standard_course_count
    courses.count - math_course_count - study_hall_count
  end

  def daily_schedule(weekday)
    sections.where(day: [weekday, "Tuesday/Thursday"]).sort_by { |c| c.start_time }
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def math_course_count
    courses.where(subject_area: "Math").count
  end

  def parents_full_name
    "#{parent.first_name.capitalize} #{parent.last_name.capitalize}"
  end

  def should_be_offered_lunch?
    !shadow_spots.select { |ss| ss.time == "10:15 AM" }.empty?
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
