ActiveAdmin.register Course do
  menu parent: "Admin"
  #
  # config.sort_order = "course"
  #
  # permit_params :name, :description, :textbooks, :grades, :suggested_grade, :subject_area
  #
  permit_params :name, 
                :grades, 
                :suggested_grade, 
                :subject_area, 
                :teacher, 
                :description, 
                :division, 
                :twice_weekly,
                :registration_period_id,
                :admin_only

  index do
    column :name
    column :grades
    column :suggested_grade
    column :subject_area
    column :admin_only

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :grades
      f.input :suggested_grade
      f.input :subject_area
      f.input :teacher
      f.input :description
      f.input :division
      f.input :twice_weekly
      f.input :registration_period
      f.input :admin_only, label: "Admin Only (not available for parent registration)"
    end
    f.actions
  end
end
