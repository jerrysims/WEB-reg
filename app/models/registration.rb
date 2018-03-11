class Registration < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  validates :course_id, presence: :true, uniqueness: { scope: :student_id }
  validate :one_class_at_a_time
  validate :student_is_correct_grade

  private

  def one_class_at_a_time
    unless student.registrations.select { |r| r.course.start_time == course.start_time }.empty?
      errors.add(:student, "already has a class at that time")
    end
  end

  def student_is_correct_grade
    unless course.grades.split(",").include?(student.grade.to_s)
      errors.add(:student, "is not in the right grade for that course")
    end
  end
end
