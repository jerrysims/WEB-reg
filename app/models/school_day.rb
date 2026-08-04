class SchoolDay < ApplicationRecord
  has_many :attendance_entries, dependent: :destroy
  has_many :attendance_notices, dependent: :destroy

  validates :date, presence: true, uniqueness: true
  validates :day_name, presence: true
end
