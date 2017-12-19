ActiveAdmin.register ShadowSpot do
  form do |f|
    f.input :date, as: :date_picker
    f.input :time, as: :select, collection: [ "8:45 AM", "10:15 AM" ]
    f.input :subject, as: :select, collection: [ "Science", "Literature" ]
    actions
  end
  permit_params :time, :subject, :date

  index do
    column :time
    column :date
    column :subject
  end
end
