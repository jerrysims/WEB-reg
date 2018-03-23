class Course < ActiveRecord::Base
  has_many :course_corequisites
  has_many :corequisites, through: :course_corequisites
  has_many :registrations, dependent: :destroy
  has_many :students, through: :registrations
  has_many :wait_listed_students, dependent: :destroy
  has_and_belongs_to_many :products

  validates :day, presence: true
  validates :name, presence: true
  validates :grades, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def waitlist
    wait_listed_students.order(:created_at).map { |entry| entry.student }
  end

  def at_max?
    students.count >= class_maximum
  end

  def fee
    products.empty? ? 0 : products.first.unit_price
  end

end
