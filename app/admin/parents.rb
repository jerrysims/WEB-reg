ActiveAdmin.register Parent do
  menu parent: "Admin"

  form do |f|
    f.input :email
    f.input :first_name
    f.input :last_name
    f.input :phone_number
    f.input :street_address_1, as: :string
    f.input :street_address_2, as: :string
    f.input :city, as: :string
    f.input :state, as: :string
    f.input :zip_code, as: :string
    f.input :tuition_preference, as: :select, collection: ["Monthly", "Semester"]
    actions
  end

  permit_params :first_name,
                :last_name,
                :email,
                :phone_number,
                :street_address_1,
                :street_address_2,
                :city,
                :state,
                :zip_code,
                :tuition_preference

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :tuition_preference
    column :sign_in_count
    column "# of Students" do |p|
      p.students.count
    end
    actions
  end

  filter :first_name
  filter :last_name
  filter :students, as: :select, collection: Student.all.order(last_name: :asc)
end
