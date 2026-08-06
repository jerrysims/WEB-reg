namespace :dev do
  desc "Seed local demo attendance data (students, registrations, school days, attendance entries, attendance notices)"
  task seed_attendance_demo: :environment do
    unless Rails.env.development? || ENV["ALLOW_NON_DEV"] == "1"
      abort("This task is intended for local development only. Set ALLOW_NON_DEV=1 to override.")
    end

    rp = RegistrationPeriod::CURRENT_ACADEMIC_YEAR || RegistrationPeriod.academic.order(open_date: :desc).first
    abort("No academic registration period found.") if rp.nil?

    sections = Section.joins(:course)
                      .where(courses: { registration_period_id: rp.id })
                      .where.not(day: [nil, ""])
                      .where.not(start_time: nil, end_time: nil)
                      .to_a

    abort("No usable sections found in #{rp.name}.") if sections.empty?

    puts "Seeding attendance demo data for #{rp.name}..."

    created_students = []

    20.times do |i|
      grade = rand(5..12)

      parent = Parent.create!(
        first_name: "DemoParent#{i + 1}",
        last_name: "Attendance",
        email: "demo.parent.#{Time.current.to_i}.#{i + 1}@example.com",
        phone_number: "615555#{format('%04d', i + 1)}",
        password: "password123",
        street_address_1: "#{100 + i} Demo Lane",
        city: "Nashville",
        state: "TN",
        zip_code: "37209"
      )

      student = Student.create!(
        first_name: "Student#{i + 1}",
        last_name: "Demo",
        date_of_birth: Date.current - rand(11..17).years,
        emergency_contact: "Emergency Contact #{i + 1}",
        emergency_phone: "615777#{format('%04d', i + 1)}",
        grade: grade,
        parent: parent,
        pronouns: "they/them",
        race: "Prefer not to say"
      )

      AdditionalContact.create!(
        first_name: "AltParent#{i + 1}",
        last_name: "Demo",
        email: "alt.parent.#{Time.current.to_i}.#{i + 1}@example.com",
        phone: "615888#{format('%04d', i + 1)}",
        student: student
      )

      eligible_sections = sections.select { |section| grade_allowed_in_section?(grade, section) }
      target_count = rand(3..5)

      chosen_sections = []
      attempts = 0
      while chosen_sections.size < target_count && attempts < 50
        attempts += 1
        candidate = eligible_sections.sample
        next if candidate.nil? || chosen_sections.include?(candidate)

        begin
          Registration.create!(
            student: student,
            section: candidate,
            user: parent,
            status: "confirmed"
          )
          chosen_sections << candidate
        rescue StandardError
          next
        end
      end

      if chosen_sections.size < 3
        puts "Student #{student.full_name}: only enrolled in #{chosen_sections.size} section(s)."
      end

      created_students << student
    end

    school_days = build_recent_instruction_days(rp.open_date || Date.current, rp.close_date || Date.current + 60.days, 8).map do |date|
      school_day = SchoolDay.find_or_create_for!(date)
      school_day.build_daily_roster!
      school_day
    end

    student_ids = created_students.map(&:id)

    school_days.each do |school_day|
      school_day.attendance_entries.where(student_id: student_ids).find_each do |entry|
        entry.update!(status: weighted_status)
      end
    end

    all_entries = AttendanceEntry.where(school_day_id: school_days.map(&:id), student_id: student_ids)
    notice_entries = all_entries.where(status: %w[absent tardy early_dismissal]).to_a.sample(15)

    notice_entries.each do |entry|
      AttendanceNotice.find_or_create_by!(school_day: entry.school_day, student: entry.student) do |notice|
        notice.kind = notice_kind_for_status(entry.status)
        notice.status = %w[pending approved].sample
        notice.notes = "Auto-generated #{notice.kind.humanize.downcase} notice"
      end
    end

    puts "Done."
    puts "Created students: #{created_students.count}"
    puts "School days touched: #{school_days.count}"
    puts "Attendance entries in scope: #{all_entries.count}"
    puts "Attendance notices created: #{notice_entries.count}"
  end

  def grade_allowed_in_section?(grade, section)
    parsed = parse_grades(section.grades)
    parsed.include?(grade)
  end

  def parse_grades(grades_text)
    return [] if grades_text.blank?

    values = grades_text.split(/[,\s\/;]+/).map(&:strip).reject(&:blank?)
    grades = []

    values.each do |token|
      if token.match?(/^\d+\-\d+$/)
        low, high = token.split("-").map(&:to_i)
        grades.concat((low..high).to_a)
      elsif token.match?(/^\d+$/)
        grades << token.to_i
      end
    end

    grades.uniq
  end

  def build_recent_instruction_days(start_date, end_date, count)
    dates = []
    date = start_date

    while dates.size < count && date <= end_date
      day_name = date.strftime("%A")
      dates << date if ["Tuesday", "Thursday"].include?(day_name)
      date += 1.day
    end

    dates
  end

  def weighted_status
    roll = rand
    return "present" if roll < 0.78
    return "not_yet_reported" if roll < 0.88
    return "absent" if roll < 0.95
    return "tardy" if roll < 0.985

    "early_dismissal"
  end

  def notice_kind_for_status(status)
    case status
    when "absent"
      "absence"
    when "tardy"
      "tardy"
    when "early_dismissal"
      "early_dismissal"
    else
      %w[absence tardy early_dismissal].sample
    end
  end
end
