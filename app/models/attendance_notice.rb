class AttendanceNotice < ApplicationRecord
  KINDS = %w[absence tardy early_dismissal].freeze
  STATUSES = %w[pending approved].freeze

  belongs_to :student
  belongs_to :school_day

  validates :student, presence: true
  validates :school_day, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :student_id, uniqueness: { scope: :school_day_id }

  def self.kinds_for_select
    KINDS.map { |kind| [kind.humanize, kind] }
  end

  def self.statuses_for_select
    STATUSES.map { |status| [status.humanize, status] }
  end
end
