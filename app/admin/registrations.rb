ActiveAdmin.register Registration do
  menu parent: "Admin"

  permit_params :section_id, :student_id, :status

  filter :section,
         as: :select,
         collection: Hash[
           Section.all.order(
             course_id: :asc, day: :desc, start_time: :asc
           ).map{ |s| ["#{s.course.name.truncate(20)}, #{s.day}, #{s.start_time.strftime("%l:%M")}",
                          s.id]}
         ]

  filter :student,
         as: :select,
         collection: Student.enrolled.order(last_name: :asc, first_name: :asc)

  scope :all, default: true
  scope :missing_invoices

  form do |f|
    f.inputs do
      f.input :section, as: :select, collection: options_from_collection_for_select(Section.all.sort_by { |c| c.name }, :id, lambda { |c| "#{c.name}, #{c.day}, #{c.start_time.strftime("%l:%M")}"})
      f.input :student, as: :select, collection: options_from_collection_for_select(Student.all.sort_by { |s| s.last_name.downcase }, :id, lambda { |s| "#{s.full_name}"})
      f.input :status, as: :select, collection: %w(pending confirmed)
      f.hidden_field :user_id, value: current_parent.id

      actions
    end
  end

  controller do
    def registration_params
      params.require(:registration).permit(:section_id, :student_id, :status, :user_id)
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
    column "Student ID", :student_id
    column "Section ID", :section_id
    column :"Parent ID" do |r|
      r.student.parent_id
    end
    column :status

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
    column "Student ID" do |r|
      r.student_id
    end
    column "Section ID" do |r|
      r.section_id
    end
    column "Parent ID" do |r|
      r.student.parent_id
    end
  end
end
