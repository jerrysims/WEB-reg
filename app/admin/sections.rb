ActiveAdmin.register Section do
  menu parent: "Admin"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :description, :textbooks, :grades, :day, :start_time, :end_time, :class_minimum, :class_maximum, :suggested_grade, :subject_area
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column :name, sortable: :name do |section|
      link_to section.course.name, admin_section_path(section)
    end
    column "Day/Time" do |section|
      "#{section.day}, #{section.start_time.strftime("%l:%M")}"
    end
    column "Seats Filled" do |section|
      section.students.count
    end
    column :class_maximum
    column :class_minimum
    column :grades
    column :suggested_grade
    column :subject_area
    column "Waitlist Count" do |section|
      section.wait_listed_students.count
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
        table_for resource.registrations do
          column "name" do |registration|
            link_to registration.student.full_name
          end
        end
      end
      panel "Waitlisted Students" do
        table_for resource.wait_listed_students do
          column "name" do |wait_listed_student|
            wait_listed_student.student.full_name
          end
        end
      end
    end
  end
end
