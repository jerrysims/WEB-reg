class Subject < ActiveRecord::Base
  has_many :shadow_spots
  has_many :teachers

  validates :name, presence: :true
  validates :grade, presence: :true, uniqueness: { scope: :name }
end
