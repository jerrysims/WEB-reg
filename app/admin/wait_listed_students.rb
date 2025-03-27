ActiveAdmin.register WaitListedStudent do
  form do |f|
    f.input :section, as: :select, collection: options_from_collection_for_select(
      Section.joins(:course).where(courses: { registration_period_id: [RegistrationPeriod::CURRENT_RP.id, RegistrationPeriod::CURRENT_ACADEMIC_YEAR.id] })
             .includes(:registration_period, :course)
             .sort_by { |s| [s.registration_period.name, s.course.name] },
      :id,
      lambda { |s| "#{s.course.name}, #{s.day}, #{s.start_time.strftime("%l:%M")} (#{s.registration_period.name})" }
    )
    f.input :student, as: :select, collection: options_from_collection_for_select(
      Student.enrolled([RegistrationPeriod::CURRENT_RP, RegistrationPeriod::CURRENT_ACADEMIC_YEAR])
             .order(:last_name, :first_name),
      :id,
      lambda { |s| "#{s.full_name}" }
    )

    actions
  end

  permit_params :section_id, :student_id
end
