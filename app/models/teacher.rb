class Teacher < Parent
  has_many :teachers_sections
  has_many :sections, through: :teachers_sections
  has_many :courses, through: :sections
  has_many :registrations, through: :sections
  has_many :parents, through: :students
end
