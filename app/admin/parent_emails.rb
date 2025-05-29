ActiveAdmin.register Parent, as: "Parent Emails" do
  menu parent: "Reports"

  # Remove all vanilla filters, keep only the custom Registration Period filter in the sidebar
  config.filters = false

  sidebar "Filter by Registration Period", only: :index do
    form_tag admin_parent_emails_path, method: :get do
      select_tag(
        :registration_period_id,
        options_from_collection_for_select(RegistrationPeriod.all.order(:name), :id, :name, params[:registration_period_id]),
        include_blank: "All Registration Periods"
      ) +
      submit_tag("Filter", name: nil)
    end
  end

  index do |parent|
    column "Registered Parent" do |p|
      p.full_name
    end
    column :email
    column :secondary_email
  end

  controller do
    def scoped_collection
      if params[:registration_period_id].present?
        rp_id = params[:registration_period_id]
        Parent.joins(students: { registrations: { section: { course: :registration_period } } })
              .where(courses: { registration_period_id: rp_id })
              .distinct
      else
        super
      end
    end

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
