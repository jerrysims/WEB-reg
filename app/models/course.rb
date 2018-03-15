class Course < ActiveRecord::Base
  has_many :course_corequisites
  has_many :corequisites, through: :course_corequisites
  has_many :registrations
  has_many :students, through: :registrations

  validates :day, presence: true
  validates :name, presence: true
  validates :grades, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
