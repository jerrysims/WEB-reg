class RegistrationPeriod < ApplicationRecord
  CURRENT_RP = RegistrationPeriod.find_by(name: "2025-26 Academic Year")
  CURRENT_ACADEMIC_YEAR = RegistrationPeriod.find_by(name: "2024-25 Academic Year")
  RP_TYPES= %w(academic extracurricular)
  RP_STATUSES = %W(future teachers seniors juniors returning all closed)
  

  validates_inclusion_of :rp_type, in: RP_TYPES
  validates_inclusion_of :status, in: RP_STATUSES
  validates :name, uniqueness: true

  scope :open, -> { where(open_date: ..Date.today, close_date: Date.today..) }
  scope :academic, ->{ where(rp_type: "academic") }
  scope :extracurricular, ->{ where(rp_type: "extracurricular") }

  has_many :courses
  has_many :products
  has_many :sections, through: :courses
end
