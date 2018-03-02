class Course < ActiveRecord::Base
  has_many :course_corequisites
  has_many :corequisites, through: :course_corequisites
end
