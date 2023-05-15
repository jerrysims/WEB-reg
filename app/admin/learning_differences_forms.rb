ActiveAdmin.register LearningDifferencesForm do
  menu parent: "Admin"

  filter :student, as: :select, collection: Student.all.order(last_name: :asc)
end
