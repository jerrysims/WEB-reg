ActiveAdmin.register Course, as: "Daily Sign-in Sheet" do
  menu parent: "Reports"

  filter :name, as: :select

  index do
  
  end

  controller do
    def index
      index! do |format|
        format.xls {
          spreadsheet = DailySignInSheets.new
          send_data spreadsheet.generate_xls, filename: "daily_sign_in_sheets_#{Time.now.strftime("%Y%m%d_%H%M")}.xls"
        }
      end
    end
  end
end
