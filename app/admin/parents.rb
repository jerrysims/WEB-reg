ActiveAdmin.register Parent do
  menu parent: "Admin"

  form do |f|
    f.input :email
    f.input :first_name
    f.input :last_name
    f.input :phone_number
    f.input :password
    f.input :password_confirmation
    actions
  end
  permit_params :first_name, :last_name, :email, :phone_number, :password, :password_confirmation

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
