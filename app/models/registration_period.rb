class RegistrationPeriod < ApplicationRecord
  RP_TYPES= %w(academic extracurricular)

  validates_inclusion_of :rp_type, in: RP_TYPES
  validates :name, uniqueness: true


  scope :open, ->{ where("open_date <= ?", Date.today).where("close_date >= ?", Date.today) } 
  scope :academic, ->{ where(rp_type: "academic") }
  scope :extracurricular, ->{ where(rp_type: "extracurricular") }

  has_many :courses
  has_many :sections, through: :courses
end
