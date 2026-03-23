ActiveAdmin.register Invoice do
  menu parent: "Admin"

  form do |f|
    f.input :parent
    f.input :registration_period
    f.input :closed
    actions
  end

  permit_params :parent_id, :registration_period_id, :closed

  index do
    column :id
    column :parent
    column :registration_period
    column :closed
    column "Total Due" do |invoice|
      invoice.total_due
    end
    actions
  end

  filter :parent
  filter :registration_period
  filter :closed

  csv do
    column :id
    column :parent_id
    column "Parent Name" do |invoice|
      invoice.parent.present? ? invoice.parent.full_name : ""
    end
    column :registration_period_id
    column :closed
    column :total_due
  end
end