ActiveAdmin.register Student do
  menu parent: "Admin"

  form do |f|
    f.input :first_name
    f.input :last_name
    f.input :web_email
    f.input :grade
    f.input :parent
    f.input :date_of_birth
    f.input :pronouns, as: :select, collection: Student::PRONOUN_OPTIONS
    actions
  end
  permit_params :first_name, :last_name, :parent_first_name, :parent_last_name, :grade,
                :student_email, :web_email, :pronouns, :date_of_birth

  index do
    column :first_name
    column :last_name
    column :grade
    column :web_email
    column :student_email
    column :parent
    column "Parent ID" do |c|
      c.parent_id
    end
    column :confirmed_grade
    actions
  end

  filter :first_name
  filter :last_name
  filter :parent, as: :select, collection: Parent.all.order(last_name: :asc)
  filter :grade
  filter :date_of_birth
  filter :race
  filter :pronouns

  csv do
    column :id
    column :first_name
    column :last_name
    column :date_of_birth
    column :parent_id
    column "Parent Name" do |student|
      student.parent.present? ? student.parent.full_name : ""
    end
    column "Parent Email" do |student|
      student.parent.present? ? student.parent.email: ""
    end
    column "Street Address 1" do |student|
      student.parent.street_address_1
    end
    column "Street Address 2" do |student|
      student.parent.street_address_2
    end
    column "City, St, Zip" do |student|
      p = student.parent
      "#{p.city}, #{p.state} #{p.zip_code}"
    end
  end
end
