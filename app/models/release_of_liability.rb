class ReleaseOfLiability < ApplicationRecord
  belongs_to :parent
  belongs_to :registration_period
  
  validates :parent_id, uniqueness: { scope: :registration_period_id, message: "You have already filled out an agreement for this registration period" }
  validates_presence_of :waiver_terms, :signature

  def status
    return "complete" if waiver_terms && signature

    "incomplete"
  end
end

