class QuarterlyScore < ApplicationRecord
  belongs_to :registration

  validates :registration, uniqueness: { scope: :quarter }
  validates :quarter, presence: true

  delegate :student, :section, to: :registration

  enum quarter: { q1: 1, q2: 2, q3: 3, q4: 4 }

  attribute :published, :boolean, default: false
end
