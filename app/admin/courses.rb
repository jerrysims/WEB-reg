ActiveAdmin.register Course do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    column :name, sortable: :name do |course|
      link_to course.name, admin_course_path(course)
    end
    column "Seats Filled" do |course|
      course.students.count
    end
    column :class_maximum
    column :class_minimum
    column "Waitlist Count" do |course|
      course.wait_listed_students.count
    end
    actions
  end


  show do
    attributes_table do
      row :name
      row :description
      row "Class Time" do |c|
        "#{c.day}, #{c.start_time.strftime("%l:%M %p")}"
      end
      row "Capacity" do |c|
        "#{c.students.count} of #{c.class_maximum} filled"
      end
      panel "Enrolled Students" do
        table_for course.registrations do
          column "name" do |registration|
            registration.student.full_name
          end
        end
      end
      panel "Waitlisted Students" do
        table_for course.wait_listed_students do
          column "name" do |wait_listed_student|
            wait_listed_student.student.full_name
          end
        end
      end
    end
    active_admin_comments
  end
end
