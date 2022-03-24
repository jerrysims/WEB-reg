ActiveAdmin.register WaitListedStudent do
  form do |f|
    f.input :section, as: :select, collection: options_from_collection_for_select(Section.all.sort_by { |c| c.name }, :id, lambda { |c| "#{c.name}, #{c.day}, #{c.start_time.strftime("%l:%M")}"})
    f.input :student, as: :select, collection: options_from_collection_for_select(Student.all.sort_by { |s| s.last_name.downcase }, :id, lambda { |s| "#{s.full_name}"})

    actions
  end

  permit_params :section_id, :student_id
end
