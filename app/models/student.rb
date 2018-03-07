class Student < ActiveRecord::Base
  belongs_to :parent
  has_many :student_shadows
  has_many :shadow_spots, through: :student_shadows
  has_many :registrations
  has_many :courses, through: :registrations

  accepts_nested_attributes_for :student_shadows

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :grade, presence: true
  validates :emergency_contact, presence: true
  validates :emergency_phone, presence: true

  attr_accessor :shadow_spot

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def parents_full_name
    "#{parent.first_name.capitalize} #{parent.last_name.capitalize}"
  end

  def should_be_offered_lunch?
    !shadow_spots.select { |ss| ss.time == "10:15 AM" }.empty?
  end

end
