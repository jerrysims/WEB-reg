class ReleaseOfLiability < ApplicationRecord
  belongs_to :parent
  belongs_to :registration_period

  validates_presence_of :waiver_terms, :signature

  def status
    return "complete" if waiver_terms && signature

    "incomplete"
  end
end

