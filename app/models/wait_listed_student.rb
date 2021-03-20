class WaitListedStudent < ActiveRecord::Base
  belongs_to :section
  has_one :course, through: :section
  belongs_to :student

  validates :section_id, presence: true, uniqueness: { scope: :student_id }
  validates :student_id, presence: true
  # validate :student_is_correct_grade

  private

  # def student_is_correct_grade
  #   unless course.grades.split(",").include?(student.grade.to_s)
  #     errors.add(:student, "is not in the right grade for that course")
  #   end
  # end
end
