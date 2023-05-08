class ReleaseOfLiability < ApplicationRecord
  belongs_to :parent

  validates_presence_of :waiver_terms, :donelson_heights_terms, :signature

  def status
    return "complete" if waiver_terms && donelson_heights_terms && signature

    "incomplete"
  end
end

