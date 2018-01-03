class Student < ActiveRecord::Base
  has_one :student_shadow
  has_one :shadow_spot, through: :student_shadow
  belongs_to :parent
  belongs_to :shadow_spot
  accepts_nested_attributes_for :student_shadow

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
