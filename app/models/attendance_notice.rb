class AttendanceNotice < ApplicationRecord
  belongs_to :student
  belongs_to :school_day

  validates :student, presence: true
  validates :school_day, presence: true
  validates :kind, presence: true, inclusion: { in: %w[absence tardy early_dismissal] }
  validates :status, presence: true, inclusion: { in: %w[pending approved] }
  validates :student_id, uniqueness: { scope: :school_day_id }
end
