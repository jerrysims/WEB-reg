ActiveAdmin.register RegistrationLog do
  menu parent: "Admin"
  actions :index
  config.sort_order = "created_at"

  permit_params :student_id, :section_id, :user_id, :previous_status, :new_status, :created_at

  index do
    column "Student", sortable: :"students.last_name" do |r|
      r.student.full_name
    end
    column "Section Name", sortable: :"sections.name" do |r|
      r.section.name
    end
    column :previous_status
    column :new_status
    column :created_at
    column "Performed by", sortable: :"users.full_name" do |r|
      r.user.full_name
    end
  end
end
