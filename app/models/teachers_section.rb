class TeachersSection < ActiveRecord::Base
  belongs_to :section
  belongs_to :teacher

  validates :teacher, uniqueness: { scope: :section }
end