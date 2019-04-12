ActiveAdmin.register Course, as: "Master Schedule" do
  menu parent: "Reports"

  filter :name, as: :select

  index do

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
