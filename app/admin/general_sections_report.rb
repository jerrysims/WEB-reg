ActiveAdmin.register Section, as: "General Sections Report" do
  menu parent: "Reports"

  index do |section|
    column :course, sortable: :"courses.name" do |section|
      link_to section.course.name, admin_section_path(section)
    end
    column :day
    column :start_time
    column "Student Count" do |s|
      s.students.count
    end
  end

  index download_links: [:xls]


  controller do
    def index
      index! do |format|
        format.xls {
          spreadsheet = GeneralSectionsReport.new
          send_data(
            spreadsheet.generate_xls,
            filename: "general_sections_report_#{Time.now.strftime("%m/%d/%Y")}.xls"
          )
        }
      end
    end
  end
end
