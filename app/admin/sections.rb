ActiveAdmin.register Section do
  menu parent: "Admin"

  config.sort_order = "course"

  permit_params :name, :description, :textbooks, :grades, :day, :start_time, :end_time, :user_id,
                :class_minimum, :class_maximum, :suggested_grade, :subject_area, :course_id

  member_action :drop, only: :show, method: :post do
    student = Student.find(params[:student_id])
    section = Section.find(params[:id])

    if Registration.find_by(student_id: params[:student_id], section_id: params[:section_id]).destroy
      flash[:notice] = "#{student.full_name} was dropped from #{section.name}"
    end

    redirect_to admin_section_path(params[:id])
  end

  member_action :drop_from_waitlist, only: :index, method: :post do
    student = Student.find(params[:student_id])
    section = Section.find(params[:id])

    if WaitListedStudent.find_by(student_id: params[:student_id], section_id: params[:id]).destroy
      flash[:notice] = "#{student.full_name} was dropped from the waitlist for #{section.name}"
    end

    redirect_to admin_section_path(params[:id])
  end

  member_action :enroll, only: :index, method: :post do
    student = Student.find(params[:student_id])
    section = Section.find(params[:id])

    ActiveRecord::Base.transaction do
      reg =  Registration.find_or_create_by(
        section_id: params[:id],
        student_id: params[:student_id],
        user_id: current_parent.id
      )
      if reg.valid?
        WaitListedStudent.find_by(section_id: params[:id], student_id: params[:student_id]).destroy
        flash[:notice] = "#{student.full_name} is now enrolled in #{section.name}"
      else
        message = ""
        reg.errors.messages.each do |m|
          message << "#{m[0]} #{m[1][0]}... "
        end
        flash[:notice] = message
      end
    end

    redirect_to admin_section_path(params[:id])
  end

  index download_links: [:xls, :csv]

  index do
    column :course, sortable: :"courses.name" do |section|
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
      panel "Students" do
        columns do
          column do
            index_table_for resource.registrations do |t|
              column "Enrolled Students" do |registration|
                columns do
                  column do
                    link_to registration.student.full_name
                  end
                  column do
                    link_to "Drop", drop_admin_section_path(
                      student_id: registration.student_id, section_id: registration.section_id
                    ), method: :post
                  end
                  column
                  column
                end
              end
            end
          end
          column do
            index_table_for resource.wait_listed_students do
              column "Wait List" do |wait_listed_student|
                columns do
                  column do
                    wait_listed_student.student.full_name
                  end
                  column do
                    link_to 'Enroll in Class', enroll_admin_section_path(
                      student_id: wait_listed_student.student_id), method: :post
                  end
                  column do
                    link_to "Drop from Waitlist", drop_from_waitlist_admin_section_path(
                      student_id: wait_listed_student.student_id), method: :post
                  end
                  column
                  column
                end
              end
            end
          end
        end
      end
    end
  end

  csv do
    column "Section Name" do |s|
      s.name
    end
    column :id
    column :day
    column :start_time
    column :end_time
    column :class_minimum
    column :class_maximum
    column :created_at
    column :updated_at
  end

  controller do
    def scoped_collection
      Section.includes(:course)
    end
  end
end
