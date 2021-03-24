ActiveAdmin.register Section, as: "Class Rosters" do
  menu parent: "Reports"

  # filter :name, as: :select

  index do |section|
    column :name
    column do |section|
      unless section.registrations.empty?
        table_for section.registrations do
          column "Class Roster" do |registration|
            registration.student.full_name
          end
        end
      end
    end

  end
  controller do
    def index
      index! do |format|
        format.xls {
          spreadsheet = ClassRostersReport.new Section.all.sort_by { |c| c.name }
          send_data spreadsheet.generate_xls, filename: "class_rosters_#{Time.now.strftime("%Y%m%d_%H%M")}.xls"
        }
      end
    end
  end


  csv do
    column "Course Name / Time" do |c|
      "#{c.name}, #{c.start_time}"
    end
    column "Students" do |c|
      c.registrations.map { |r| r.student.full_name }
    end
  end
end
