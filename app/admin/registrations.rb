ActiveAdmin.register Registration do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :course_id, :student_id, :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    column "Student" do |r|
      r.student.full_name
    end
    column "Student Grade" do |r|
      r.student.grade
    end
    column "Course Name" do |r|
      r.course.name
    end
    column "Day / Time" do |r|
      r.course.day + ", " + r.course.start_time.strftime("%l:%M %p")
    end
    column "Parent Name" do |r|
      r.student.parent.full_name
    end
    column "Payment Plan" do |r|
      r.student.parent.tuition_preference
    end
    actions
  end

  csv do
    column "Student" do |r|
      r.student.full_name
    end
    column "Student Grade" do |r|
      r.student.grade
    end
    column "Course Name" do |r|
      r.course.name
    end
    column "Day / Time" do |r|
      r.course.day + ", " + r.course.start_time.strftime("%l:%M %p")
    end
    column "Parent Name" do |r|
      r.student.parent.full_name
    end
    column "Payment Plan" do |r|
      r.student.parent.tuition_preference
    end
  end
end
