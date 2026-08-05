ActiveAdmin.register SchoolDay do
  menu parent: "Admin", label: "Daily Check-In"

  permit_params :date, :day_name, :active

  action_item :open_today_check_in, only: :index do
    link_to "Open Today's Check-In", start_today_admin_school_days_path, method: :post
  end

  collection_action :start_today, method: :post do
    school_day = SchoolDay.find_or_create_for!(Date.current)
    school_day.build_daily_roster!

    redirect_to admin_school_day_path(school_day), notice: "Daily check-in opened for #{school_day.date.strftime('%A, %b %-d')}"
  end

  member_action :build_roster, method: :post do
    resource.build_daily_roster!

    redirect_to admin_school_day_path(resource), notice: 'Roster refreshed from active registrations.'
  end

  member_action :mark_all_present, method: :post do
    resource.attendance_entries.where(status: 'not_yet_reported').update_all(status: 'present', updated_at: Time.current)

    redirect_to admin_school_day_path(resource), notice: 'All unreported students were marked present.'
  end

  member_action :update_entry, method: :patch do
    entry = resource.attendance_entries.find(params[:entry_id])
    entry.update!(status: params[:status], notes: params[:notes])

    redirect_to admin_school_day_path(resource), notice: "Updated attendance for #{entry.student.full_name}."
  end

  index do
    selectable_column
    column :date
    column :day_name
    column :active
    column 'Entries' do |school_day|
      school_day.attendance_entries.count
    end
    column 'Unreported' do |school_day|
      school_day.attendance_entries.where(status: 'not_yet_reported').count
    end
    column 'Absent' do |school_day|
      school_day.attendance_entries.where(status: 'absent').count
    end
    actions defaults: true do |school_day|
      link_to 'Build Roster', build_roster_admin_school_day_path(school_day), method: :post
    end
  end

  show do
    attributes_table do
      row :date
      row :day_name
      row :active
      row :created_at
      row :updated_at
    end

    panel 'Check-In Controls' do
      div do
        span link_to('Build / Refresh Roster', build_roster_admin_school_day_path(resource), method: :post)
      end
      div style: 'margin-top: 8px;' do
        span link_to('Mark Unreported as Present', mark_all_present_admin_school_day_path(resource), method: :post)
      end
    end

    panel 'Attendance Entries' do
      table_for resource.attendance_entries.includes(:student).order('students.last_name ASC').references(:students) do
        column('Student') { |entry| entry.student.full_name }
        column('Grade') { |entry| entry.student.grade }
        column('Status') { |entry| status_tag(entry.status) }
        column('Notes') { |entry| entry.notes }
        column('Update') do |entry|
          div do
            form action: update_entry_admin_school_day_path(resource), method: 'post' do
              text_node hidden_field_tag(:_method, 'patch')
              text_node hidden_field_tag(:authenticity_token, form_authenticity_token)
              text_node hidden_field_tag(:entry_id, entry.id)
              text_node select_tag(:status, options_for_select(AttendanceEntry.statuses_for_select, entry.status))
              text_node text_field_tag(:notes, entry.notes, placeholder: 'Optional note', style: 'margin-left: 6px;')
              text_node submit_tag('Save', style: 'margin-left: 6px;')
            end
          end
        end
      end
    end
  end

  filter :date
  filter :day_name
  filter :active
end
