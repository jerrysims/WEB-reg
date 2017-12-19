ActiveAdmin.register Student do
  form do |f|
    f.input :first_name
    f.input :last_name
    f.input :parent_first_name
    f.input :parent_last_name
    f.input :grade
    f.input :email_address
    actions
  end
  permit_params :first_name, :last_name, :parent_first_name, :parent_last_name

  index do
    column :first_name
    column :last_name
    column :parent_first_name
    column :parent_last_name
    column :grade
    column :email_address
  end
end
