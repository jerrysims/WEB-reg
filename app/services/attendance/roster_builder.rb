module Attendance
  class RosterBuilder
    def self.create_for!(school_day)
      new(school_day).create_for!
    end

    def initialize(school_day)
      @school_day = school_day
    end

    def create_for!
      expected_student_ids.each do |student_id|
        AttendanceEntry.find_or_create_by!(school_day: @school_day, student_id: student_id) do |entry|
          entry.status = 'not_yet_reported'
        end
      end
    end

    private

    def expected_student_ids
      @expected_student_ids ||= Registration.includes(:section).find_each.filter_map do |registration|
        next unless section_meets_on_day?(registration.section)

        registration.student_id
      end.uniq
    end

    def section_meets_on_day?(section)
      return false unless section&.day

      section.day == @school_day.day_name || section.day == 'Tuesday/Thursday'
    end
  end
end
