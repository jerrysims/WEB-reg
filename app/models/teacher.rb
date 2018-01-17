class Teacher < ActiveRecord::Base
  belongs_to :subject
  has_many :shadow_spots, through: :subject
end
