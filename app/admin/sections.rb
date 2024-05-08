ActiveAdmin.register Section do
  menu parent: "Admin"

  config.sort_order = "course"

  permit_params :name, :description, :textbooks, :grades, :day, :start_time, :end_time, :user_id,
                :class_minimum, :class_maximum, :suggested_grade, :subject_area, :course_id, :teacher_id

  action_item :assign_teacher do
    link_to "Assign Teachers", new_admin_teacher_assignment_path 
  end

  action_item :new_wait_list_student do
    link_to "Add New Waitlist Student", new_admin_wait_listed_student_path
  end

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

  index do
    column :course, sortable: :"courses.name" do |section|
      link_to section.course.name, admin_section_path(section)
    end
    column :registration_period do |section|
      section.course.registration_period
    end
    column "Day/Time" do |section|
      "#{section.day}, #{section.start_time.strftime("%l:%M")}"
    end
    column :teacher do |section|
      section.teachers.each do |t|
        link_to t, teacher_path(t.id)
      end
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
      row :registration_period do |s|
        s.course.registration_period
      end
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
                    link_to("#{registration.student.full_name} (#{registration.student.grade})", admin_student_schedule_path(student_id: registration.student_id), method: :post)
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
            index_table_for resource.wait_listed_students.order(created_at: :asc) do
              column "Wait List" do |wait_listed_student|
                columns do
                  column span: 2 do
                    link_to("#{wait_listed_student.student.full_name} (#{wait_listed_student.student.grade})", admin_student_schedule_path(student_id: wait_listed_student.student_id), method: :post)
                  end
                  column span: 2 do
                    "#{ wait_listed_student.created_at.strftime("%m/%d/%Y %H:%M") }"
                  end
                  column span: 2 do
                    link_to 'Enroll in Class', enroll_admin_section_path(
                      student_id: wait_listed_student.student_id), method: :post
                  end
                  column span: 2 do
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
      panel "Teachers" do
        columns do
          column do
            index_table_for resource.teachers do |t|
              column "Teachers" do |teacher|
                columns do
                  column do
                    span teacher.full_name
                  end
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
    column :grades
    column :class_minimum
    column :class_maximum
    column "Seats Filled" do |section|
      section.students.count
    end
    column :created_at
    column :updated_at
  end

  controller do
    def scoped_collection
      Section.includes(:course)
    end
  end

  filter :course_name_cont, as: :select, collection: Course.all.order(name: :asc).pluck(:name).uniq
  filter :course_registration_period_id, as: :select, collection: -> { RegistrationPeriod.pluck(:name, :id) }, label: 'Registration Period' 
end
