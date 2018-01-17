class Subject < ActiveRecord::Base
  has_one :shadow_spot
  has_one :teacher

  validates :name, presence: :true
  validates :grade, presence: :true, uniqueness: { scope: :name }
end
