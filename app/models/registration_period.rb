class RegistrationPeriod < ApplicationRecord
  RP_TYPES= %w(academic extracurricular)

  validates_inclusion_of :rp_type, in: RP_TYPES

  scope :open, ->{ where("open_date < ?", Time.now).where("close_date > ?", Time.now) } 
  scope :academic, ->{ where(rp_type: "academic") }
  scope :extracurricular, ->{ where(rp_type: "extracurricular") }

  has_many :courses
  has_many :sections, through: :courses
end
