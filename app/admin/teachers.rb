ActiveAdmin.register Teacher do
  form do |f|
    f.input :first_name
    f.input :last_name
    f.input :email
    f.input :subject
    actions
  end
  permit_params :first_name, :last_name, :parent_first_name, :parent_last_name

  index do
    column :first_name
    column :last_name
    column :email
    column :subject
    actions
  end
end
