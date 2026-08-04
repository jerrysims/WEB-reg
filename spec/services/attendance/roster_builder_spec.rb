require 'rails_helper'

RSpec.describe Attendance::RosterBuilder do
  describe '.create_for!' do
    it 'creates attendance entries for students enrolled in sections that meet that day' do
      school_day = create(:school_day, date: Date.current, day_name: Date.current.strftime('%A'))
      course = create(:course)
      section = create(:section, course: course, day: school_day.day_name)
      student = create(:student)
      create(:registration, student: student, section: section)

      expect do
        described_class.create_for!(school_day)
      end.to change(AttendanceEntry, :count).by(1)

      entry = AttendanceEntry.last
      expect(entry.school_day).to eq(school_day)
      expect(entry.student).to eq(student)
      expect(entry.status).to eq('not_yet_reported')
    end

    it 'does not create duplicate entries when run twice for the same day' do
      school_day = create(:school_day, date: Date.current, day_name: Date.current.strftime('%A'))
      course = create(:course)
      section = create(:section, course: course, day: school_day.day_name)
      student = create(:student)
      create(:registration, student: student, section: section)

      described_class.create_for!(school_day)

      expect do
        described_class.create_for!(school_day)
      end.not_to change(AttendanceEntry, :count)
    end
  end
end
