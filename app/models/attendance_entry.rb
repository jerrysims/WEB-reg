class AttendanceEntry < ApplicationRecord
  belongs_to :student
  belongs_to :school_day

  validates :student, presence: true
  validates :school_day, presence: true
  validates :status, presence: true, inclusion: { in: %w[not_yet_reported present absent tardy early_dismissal] }
  validates :student_id, uniqueness: { scope: :school_day_id }
end
