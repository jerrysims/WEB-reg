class CourseCorequisite < ActiveRecord::Base
  belongs_to :course
  belongs_to :corequisite, class_name: "Course"
end
