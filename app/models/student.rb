class Student < ActiveRecord::Base
  has_one :student_shadow
  has_one :shadow_spot, through: :student_shadow
  belongs_to :shadow_spot
  accepts_nested_attributes_for :student_shadow

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :parent_last_name,
    presence: :true,
    uniqueness: { scope: [ :first_name, :last_name, :parent_first_name ] }

  attr_accessor :shadow_spot

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def parents_full_name
    "#{parent_first_name.capitalize} #{parent_last_name.capitalize}"
  end
end
