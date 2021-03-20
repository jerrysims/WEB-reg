class Section < ApplicationRecord
  belongs_to :course

  validates :day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :class_minimum, numericality: true, presence: true
  validates :class_maximum, numericality: true, presence: true
end
