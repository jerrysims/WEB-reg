class Registration < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  validates :course, presence: true
  validates :student, presence: true
  validates :course_id, uniqueness: { scope: :student_id }
  validate :course_has_not_reached_max
  validate :no_other_courses_in_session
  validate :one_class_at_a_time
  validate :student_is_correct_grade

  # def course
  #   Course.find(course_id)
  # end
  #
  # def student
  #   Student.find(student_id)
  # end

  private

  def course_has_not_reached_max
    if course && course.at_max?
      errors.add(:course, "is full")
    end
  end

  def no_other_courses_in_session
    return if student.registrations.empty?
    student.registrations.each do |r|
      errors.add(:student, "has a class in session at that time") if course.conflicts_with r.course
    end
  end

  def one_class_at_a_time
    unless student && student.registrations.select { |r| r.course.start_time == course.start_time && (r.course.day == course.day || r.course.day == "Tuesday/Thursday" || course.day == "Tuesday/Thursday")}.empty?
      errors.add(:student, "already has a class at that time")
    end
  end

  def student_is_correct_grade
    unless course && course.grades.split(",").include?(student.grade.to_s)
      errors.add(:student, "is not in the right grade for that course")
    end
  end
end
