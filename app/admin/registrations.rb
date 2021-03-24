ActiveAdmin.register Registration do
  menu parent: "Admin"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :section_id, :student_id, :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  form do |f|
    f.inputs do
      f.input :section, as: :select, collection: options_from_collection_for_select(Section.all.sort_by { |c| c.name }, :id, lambda { |c| "#{c.name}, #{c.day}, #{c.start_time.strftime("%l:%M")}"})
      f.input :student, as: :select, collection: options_from_collection_for_select(Student.all.sort_by { |s| s.last_name.downcase }, :id, lambda { |s| "#{s.full_name}"})
      actions
    end
  end

  controller do
    def registration_params
      params.require(:registration).permit(:section_id, :student_id)
    end

    def create
      @registration= Registration.new(registration_params)
      @registration.save!(validate: false)
      redirect_to admin_registrations_path
    end
  end


  index do
    column "Student", sortable: :"students.last_name" do |r|
      r.student.full_name
    end
    column "Student Grade", sortable: :"students.grade" do |r|
      r.student.grade
    end
    column "Section Name", sortable: :"sections.name" do |r|
      r.section.name
    end
    column "Day / Time" do |r|
      r.section.day + ", " + r.section.start_time.strftime("%l:%M %p")
    end
    column "Parent Name", sortable: :"parents.name" do |r|
      r.student.parent.full_name
    end
    column "Payment Plan", sortable: :"parent s.tuition_preference" do |r|
      r.student.parent.tuition_preference
    end
    actions
  end

  csv do
    column "Student" do |r|
      r.student.full_name
    end
    column "Student Grade" do |r|
      r.student.grade
    end
    column "Section Name" do |r|
      r.section.name
    end
    column "Day / Time" do |r|
      r.section.day + ", " + r.section.start_time.strftime("%l:%M %p")
    end
    column "Parent Name" do |r|
      r.student.parent.full_name
    end
    column "Payment Plan" do |r|
      r.student.parent.tuition_preference
    end
  end

end
