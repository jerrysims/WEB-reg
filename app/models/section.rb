class Section < ApplicationRecord
  belongs_to :course
  has_many :registrations, dependent: :destroy
  has_many :students, through: :registrations
  has_many :wait_listed_students, dependent: :destroy

  validates :day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :class_minimum, numericality: true, presence: true
  validates :class_maximum, numericality: true, presence: true

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
    day == another_section.day || day == "Tuesday/Thursday" || another_section.day == "Tuesday/Thursday"
  end

  def grades
    course.grades
  end

  def in_session time
    start_time < time && end_time > time
  end

  def name
    course.name
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
