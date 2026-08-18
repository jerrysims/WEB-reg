require 'rails_helper'

RSpec.describe Admin::DailyCheckInsController, type: :controller do
  let(:admin) do
    create(:parent).tap { |parent| parent.add_role(:admin) }
  end

  let(:current_academic_year) { RegistrationPeriod::CURRENT_ACADEMIC_YEAR }
  let(:school_day_date) { Date.new(2026, 8, 4) }

  before do
    allow(controller).to receive(:current_parent).and_return(admin)
    allow(Date).to receive(:current).and_return(school_day_date)
  end

  describe 'GET #index' do
    it 'succeeds' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'POST #start_today' do
    it 'creates the school day roster and redirects to the daily check-in' do
      student = create(:student)
      course = create(:course, registration_period: current_academic_year)
      section = create(:section, course: course, day: school_day_date.strftime('%A'))
      create(:registration, student: student, section: section)

      expect do
        post :start_today
      end.to change(AttendanceEntry, :count).by(1)

      expect(response).to redirect_to(admin_daily_check_in_path(SchoolDay.find_by(date: school_day_date)))
    end
  end

  describe 'PATCH #update_entry' do
    it 'updates an attendance entry status and notes' do
      school_day = create(:school_day, date: school_day_date, day_name: school_day_date.strftime('%A'))
      student = create(:student)
      entry = AttendanceEntry.create!(school_day: school_day, student: student, status: 'not_yet_reported')

      patch :update_entry, params: { id: school_day.id, entry_id: entry.id, status: 'present', notes: 'Arrived on time' }

      expect(entry.reload.status).to eq('present')
      expect(entry.reload.notes).to eq('Arrived on time')
    end

    it 'keeps the current status when only notes are saved' do
      school_day = create(:school_day, date: school_day_date, day_name: school_day_date.strftime('%A'))
      student = create(:student)
      entry = AttendanceEntry.create!(school_day: school_day, student: student, status: 'not_yet_reported', notes: 'Previous note')

      patch :update_entry, params: { id: school_day.id, entry_id: entry.id, notes: 'Lunch 10:15' }

      expect(entry.reload.status).to eq('not_yet_reported')
      expect(entry.reload.notes).to eq('Lunch 10:15')
    end

    it 'preserves the existing note when only the status changes' do
      school_day = create(:school_day, date: school_day_date, day_name: school_day_date.strftime('%A'))
      student = create(:student)
      entry = AttendanceEntry.create!(school_day: school_day, student: student, status: 'not_yet_reported', notes: 'Existing lunch note')

      patch :update_entry, params: { id: school_day.id, entry_id: entry.id, status: 'present' }

      expect(entry.reload.status).to eq('present')
      expect(entry.reload.notes).to eq('Existing lunch note')
    end

    it 'redirects back to the kiosk when the update comes from kiosk mode' do
      school_day = create(:school_day, date: school_day_date, day_name: school_day_date.strftime('%A'))
      student = create(:student)
      entry = AttendanceEntry.create!(school_day: school_day, student: student, status: 'not_yet_reported')

      patch :update_entry, params: { id: school_day.id, entry_id: entry.id, status: 'present', notes: 'Arrived on time', kiosk: true }

      expect(response).to redirect_to(admin_daily_check_in_kiosk_path(saved_entry_id: entry.id))
    end
  end
end