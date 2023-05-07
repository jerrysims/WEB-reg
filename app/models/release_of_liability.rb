class ReleaseOfLiability < ApplicationRecord
  belongs_to :parent

  def status
    return "complete" if waiver_terms && dalewood_terms && signature

    "incomplete"
  end
end

