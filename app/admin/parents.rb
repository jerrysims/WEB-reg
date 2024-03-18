ActiveAdmin.register Parent do
  menu parent: "Admin"

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
    column :payment_preference
    column :secondary_email
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :students, as: :select, collection: Student.all.order(last_name: :asc)
end
