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
  has_many :registrations, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :students, through: :registrations
  has_many :wait_listed_students, dependent: :destroy
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true
  validates :grades, presence: true

  def at_max?
    students.count >= class_maximum
  end

  def conflicts_with another_course
    days_overlap(another_course) &&
    (another_course.in_session(start_time) || another_course.in_session(end_time) ||
    in_session(another_course.start_time) || in_session(another_course.end_time))
  end

  def days_overlap another_course
    day == another_course.day || day == "Tuesday/Thursday" || another_course.day == "Tuesday/Thursday"
  end

  def fee
    products.empty? ? 0 : products.first.unit_price
  end

  def fee_product
    products.find_by(product_type: "fee")
  end

  def in_session time
    start_time < time && end_time > time
  end

  def waitlist
    wait_listed_students.order(:created_at).map { |entry| entry.student }
  end

end
