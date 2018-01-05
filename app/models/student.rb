class Student < ActiveRecord::Base
  has_many :student_shadows
  has_many :shadow_spots, through: :student_shadows
  belongs_to :parent
  # belongs_to :shadow_spot
  accepts_nested_attributes_for :student_shadows

  validates :first_name, presence: :true
  validates :last_name, presence: :true

  attr_accessor :shadow_spot

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def parents_full_name
    "#{parent.first_name.capitalize} #{parent.last_name.capitalize}"
  end
end
