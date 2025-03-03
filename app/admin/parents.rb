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
    column :locked
    actions
  end

  show do |parent|
    attributes_table do
      row :id
      row :email
      row :secondary_email
      row :first_name
      row :last_name
      row :phone_number
      row :street_address_1
      row :street_address_2
      row :city
      row :state
      row :zip_code
      row :locked
      row :type
      row :created_at
      row :updated_at
    end

    panel "Students" do
      table_for parent.students do
        column :id
        column :first_name
        column :last_name
        column :grade
        column :date_of_birth
        column :created_at
        column :updated_at
      end
    end
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
    column :locked
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :students, as: :select, collection: Student.all.order(last_name: :asc)
  filter :students_registrations_section_course_registration_period_name, as: :select, label: "Registration Period", collection: -> { RegistrationPeriod.pluck(:name) }
end
