ActiveAdmin.register TeachersSection, as: "Teacher Assignments" do
  menu parent: "Admin"

  form do |f|
    f.input :section, as: :select, collection: options_from_collection_for_select(Section.all.sort_by { |c| c.name }, :id, lambda { |c| "#{c.name}, #{c.day}, #{c.start_time.strftime("%l:%M")}, #{ c.course.registration_period.name}"})
    f.input :teacher, as: :select, collection: options_from_collection_for_select(Teacher.all.sort_by { |t| t.last_name.downcase }, :id, lambda { |t| "#{t.full_name}"})

    actions
  end

  permit_params :section_id, :teacher_id
end
