class PhotoConsent < ApplicationRecord
  belongs_to :parent

  def status
    return "complete" if signature

    "incomplete"
  end
end
