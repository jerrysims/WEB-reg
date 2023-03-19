ActiveAdmin.register Course do
  menu parent: "Admin"
  #
  # config.sort_order = "course"
  #
  # permit_params :name, :description, :textbooks, :grades, :suggested_grade, :subject_area
  #
  permit_params :name, :grades, :suggested_grade, :subject_area, :teacher, :description, :division, :twice_weekly

  index do
    column :name
    column :grades
    column :suggested_grade
    column :subject_area

    actions
  end
end
