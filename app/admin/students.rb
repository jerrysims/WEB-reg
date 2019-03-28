ActiveAdmin.register Student do
  menu parent: "Admin"

  form do |f|
    f.input :first_name
    f.input :last_name
    f.input :grade
    f.input :parent
    actions
  end
  permit_params :first_name, :last_name, :parent_first_name, :parent_last_name

  index do
    column :first_name
    column :last_name
    column :grade
    column :parent
    column "Parent ID" do |c|
      c.parent_id
    end
    actions
  end

  csv do
    column :id
    column :first_name
    column :last_name
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
