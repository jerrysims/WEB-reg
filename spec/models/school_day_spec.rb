require 'rails_helper'

RSpec.describe SchoolDay, type: :model do
  describe '#build_daily_roster!' do
    let(:school_day) { create(:school_day, date: Date.new(2026, 8, 4), day_name: 'Tuesday') }
    let(:student_expected) { create(:student) }
    let(:current_academic_year) { create(:registration_period, name: 'SchoolDay Spec Academic Year') }
    let(:course) { create(:course, registration_period: current_academic_year) }
    let(:section_for_day) { create(:section, course: course, day: 'Tuesday') }
    let(:section_for_other_day) { create(:section, course: course, day: 'Thursday') }

    before do
      allow(RegistrationPeriod::CURRENT_ACADEMIC_YEAR).to receive(:id).and_return(current_academic_year.id)

      create(:registration, student: student_expected, section: section_for_day)
      create(:registration, student: student_expected, section: section_for_other_day)
    end

    it 'creates attendance entries for students enrolled in sections that meet that day' do
      expect { school_day.build_daily_roster! }.to change { school_day.attendance_entries.count }.from(0).to(1)

      entry = school_day.attendance_entries.first
      expect(school_day.attendance_entries.pluck(:student_id).uniq).to eq([student_expected.id])
      expect(entry.student).to eq(student_expected)
      expect(entry.status).to eq('not_yet_reported')
    end

    it 'does not create duplicate entries when called twice' do
      school_day.build_daily_roster!

      expect { school_day.build_daily_roster! }.not_to change { school_day.attendance_entries.count }
    end
  end
end
