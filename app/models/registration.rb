class Registration < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  validates :course_id, presence: :true, uniqueness: { scope: :student_id }
  validate :one_class_at_a_time, on: :create

  private

  def one_class_at_a_time
    unless student.registrations.select { |r| r.course.start_time == course.start_time }.empty?
      errors.add(:student, "already has a class at that time")
    end
  end
end
