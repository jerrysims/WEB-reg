class PhotoConsent < ApplicationRecord
  belongs_to :parent
  
  validates :parent_id, uniqueness: { scope: :registration_period_id, message: "You have already filled out an agreement for this registration period" }

  def status
    return "complete" if signature

    "incomplete"
  end
end
