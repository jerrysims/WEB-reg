ActiveAdmin.register Student do
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
end
