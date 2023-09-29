class Section < ApplicationRecord
  belongs_to :course
  has_many :teachers_sections
  has_many :teachers, through: :teachers_sections
  has_many :registration_logs, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :students, through: :registrations
  has_many :wait_listed_students, dependent: :destroy
  

  validates :day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :class_minimum, numericality: true, presence: true
  validates :class_maximum, numericality: true, presence: true

  scope :open_seats, -> { where("students_count < class_maximum") }
  delegate :registration_period_id, to: :course
  delegate :semester, to: :course

  NUMERICAL = (1..110).to_a.reverse
  LETTER = %w(A+ A A- B+ B B- C+ C C- D+ D D- F)
  DESCRIPTIVE = %w(Excellent Satisfactory Needs_Assistance Unsatisfactory)

  GRADING_SCALES = %w(NUMERICAL LETTER DESCRIPTIVE)



  def at_max?
    students.count >= class_maximum
  end

  def conflicts_with another_section
    days_overlap(another_section) && 
    (another_section.in_session(start_time) || another_section.in_session(end_time) ||
    in_session(another_section.start_time) || in_session(another_section.end_time))
  end

  def course_fee
    course.fee
  end

  def days_overlap another_section
    (day == another_section.day || day == "Tuesday/Thursday" || another_section.day == "Tuesday/Thursday") &&
    course.registration_period == another_section.course.registration_period
  end

  def extracurricular?
    course.rp_type == "extracurricular"
  end

  def grades
    course.grades
  end

  def in_session time
    start_time < time && end_time > time
  end

  def name
    return course.name  unless extracurricular?

    "#{course.name} (#{semester})"
  end

  def open_seats_count
    class_maximum - students_count
  end

  def students_count
    students.count
  end

  def suggested_grade
    course.suggested_grade
  end

  def to_s
    "#{s.course.truncate(20)}, #{s.day}, #{s.start_time.strftime("%l:%M")}"
  end

  def waitlist
    wait_listed_students.order(:created_at).map { |entry| entry.student }
  end
end
