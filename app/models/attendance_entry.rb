class AttendanceEntry < ApplicationRecord
  STATUSES = %w[not_yet_reported present absent tardy early_dismissal].freeze

  belongs_to :student
  belongs_to :school_day

  validates :student, presence: true
  validates :school_day, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :student_id, uniqueness: { scope: :school_day_id }

  def self.statuses_for_select
    STATUSES.map { |status| [status.humanize, status] }
  end
end
