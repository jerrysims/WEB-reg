ActiveAdmin.register Subject do
  form do |f|
    f.input :name
    f.input :grade
    f.input :teacher
    actions
  end
  permit_params :first_name, :last_name, :parent_first_name, :parent_last_name

  index do
    column :name
    column :grade
    column :teacher
    actions
  end
end
