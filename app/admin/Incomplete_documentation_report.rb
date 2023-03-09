ActiveAdmin.register Parent, as: "Incomplete Documentation Report" do
  menu parent: "Reports"

  index do |parent|
    column :full_name
    column :parent_agreement do |p|
      p.parent_agreement.present? ? "Complete" : "MISSING"
    end 
    column :release_of_liability do |p|
      p.release_of_liability.present? ? "Complete" : "MISSING"
    end
    column :photo_consent do |p|
      p.photo_consent.present? ? "Complete" : "MISSING"
    end
  end

  index download_links: [:xls]

  # controller do
  #   def index
  #     index! do |format|
  #       format.xls {
  #         spreadsheet = GeneralSectionsReport.new
  #         send_data(
  #           spreadsheet.generate_xls,
  #           filename: "general_sections_report_#{Time.now.strftime("%m/%d/%Y")}.xls"
  #         )
  #       }
  #     end
  #   end
  # end
end
