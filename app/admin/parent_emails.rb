ActiveAdmin.register Parent, as: "Parent Emails" do
  menu parent: "Reports"

  index do |parent|
    column "Registered Parent" do |p|
      p.full_name
    end
    column :email
    column :secondary_email
  end

  controller do
    def index
      if request.format == Mime[:xls]
        spreadsheet = ParentEmailsReport.new
        send_data spreadsheet.generate_xls, filename: "parent_emails_#{Time.now.strftime("%Y%m%d_%H%M")}.xls"
      else
        super
      end
    end
  end

  csv do
    column "Registered Parent" do |p|
      "#{p.full_name}"
    end
    column "Email" do |p|
      p.email
    end
    column "Secondary Email" do |p|
      p.secondary_email
    end
  end
end
