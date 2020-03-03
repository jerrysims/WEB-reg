ActiveAdmin.register Registration do
  menu parent: "Admin"

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
  form do |f|
    f.inputs do
      f.input :course, as: :select, collection: options_from_collection_for_select(Course.all.sort_by { |c| c.name }, :id, lambda { |c| "#{c.name}, #{c.day}, #{c.start_time.strftime("%l:%M")}"})
      f.input :student, as: :select, collection: options_from_collection_for_select(Student.all.sort_by { |s| s.last_name }, :id, lambda { |s| "#{s.full_name}"})
      actions
    end
  end

  controller do
    def registration_params
      params.require(:registration).permit(:course_id, :student_id)
    end

    def create
      @registration= Registration.new(registration_params)
      @registration.save!(validate: false)
      redirect_to admin_registrations_path
    end
  end


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
