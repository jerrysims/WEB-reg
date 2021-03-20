class Registration < ActiveRecord::Base
  belongs_to :section
  belongs_to :student
  has_one :course, through: :section

  validates :student, presence: true
  validate :section_has_not_reached_max
  validate :no_other_sections_in_session
  validate :one_class_at_a_time
  validate :student_is_correct_grade

  private

  def section_has_not_reached_max
    if section && section.at_max?
      errors.add(:section, "is full")
    end
  end

  def no_other_sections_in_session
    return if student.nil? || student.registrations.empty?
    student.registrations.each do |r|
      errors.add(:student, "has a class in session at that time") if section.conflicts_with r.section
    end
  end

  def one_class_at_a_time
    unless student && student.registrations.select { |r| r.section.start_time == section.start_time && (r.section.day == section.day || r.section.day == "Tuesday/Thursday" || section.day == "Tuesday/Thursday")}.empty?
      errors.add(:student, "already has a class at that time")
    end
  end

  def student_is_correct_grade
    unless section && section.grades.split(",").include?(student.grade.to_s)
      errors.add(:student, "is not in the right grade for that section")
    end
  end
end
