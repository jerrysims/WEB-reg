ActiveAdmin.register Section, as: "Master Schedule" do
  menu parent: "Reports"

  # filter :name, as: :select

  index do
    column :course, sortable: :"courses.name" do |section|
      link_to section.course.name, admin_section_path(section)
    end

    column :day
    column :start_time
    
    # "section" is a word used in some display methods, so at times I am using the term "resource"
    column :students do |section|
      table_for section.students.order(last_name: :asc) do
        column do |student|
          student.full_name
        end
      end
    end

    actions
  end

  controller do
    def index
      index! do |format|
        format.xls {
          spreadsheet = MasterSchedule.new
          send_data spreadsheet.generate_xls, filename: "master_schedule_#{Time.now.strftime("%Y%m%d_%H%M")}.xls"
        }
      end
    end
  end
end
