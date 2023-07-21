class Teacher < Parent
  has_and_belongs_to_many :sections
  has_many :courses, through: :sections
  has_many :registrations, through: :sections
  has_many :parents, through: :students
end
