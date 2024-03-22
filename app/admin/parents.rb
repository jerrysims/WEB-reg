ActiveAdmin.register Parent do
  menu parent: "Admin"

  controller do
    def scoped_collection
      end_of_association_chain.includes(students: { registrations: { section: { course: :registration_period } } }).distinct
    end
  end

  form do |f|
    f.input :email
    f.input :secondary_email
    f.input :first_name
    f.input :last_name
    f.input :phone_number
    f.input :street_address_1, as: :string
    f.input :street_address_2, as: :string
    f.input :city, as: :string
    f.input :state, as: :string
    f.input :zip_code, as: :string
    f.input :locked
    f.input :type
    actions
  end

  permit_params :first_name,
                :last_name,
                :email,
                :secondary_email,
                :locked,
                :phone_number,
                :street_address_1,
                :street_address_2,
                :city,
                :state,
                :type,
                :zip_code

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :sign_in_count
    column "# of Students" do |p|
      p.students.count
    end
    actions
  end

  csv do
    rp_id = RegistrationPeriod.find_by(name: params[:q]["students_registrations_section_course_registration_period_name_eq"])
    
    column "quickbooks_id" do |p|
      "p#{p.id}"
    end
    column :id
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :street_address_1
    column :street_address_2
    column :city
    column :state
    column :zip_code
    column "2024 Tuition Frequency" do |p|
      p.tuition_preferences.find_by(registration_period: rp_id).try(:frequency)
    end
    column "2024 Payment Method" do |p|
      p.tuition_preferences.find_by(registration_period: rp_id).try(:payment_method)
    end
    column :secondary_email
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :students, as: :select, collection: Student.all.order(last_name: :asc)
  filter :students_registrations_section_course_registration_period_name, as: :select, label: "Child Registered in Period", collection: -> { RegistrationPeriod.pluck(:name) }

end
