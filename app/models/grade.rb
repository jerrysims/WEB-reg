class Grade < ApplicationRecord
  belongs_to :section
  belongs_to :student

  validates :student, uniqueness: { scope: :section }
end
