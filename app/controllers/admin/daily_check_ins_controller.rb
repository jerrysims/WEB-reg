class Admin::DailyCheckInsController < ApplicationController
  before_action :confirm_admin
  before_action :set_school_day, only: [:show, :build_roster, :mark_all_present, :update_entry, :update_notice]

  def index
    @school_days = SchoolDay.includes(:attendance_notices, attendance_entries: :student).order(date: :desc)
    @today = SchoolDay.find_or_create_for!(Date.current)
  end

  def show
    @attendance_entries = @school_day.attendance_entries.includes(:student).order('students.last_name ASC').references(:students)
    @attendance_notices_by_student_id = @school_day.attendance_notices.index_by(&:student_id)
  end

  def start_today
    school_day = SchoolDay.find_or_create_for!(Date.current)
    school_day.build_daily_roster!

    redirect_to admin_daily_check_in_path(school_day), notice: "Daily check-in opened for #{school_day.date.strftime('%A, %b %-d')}"
  end

  def build_roster
    @school_day.build_daily_roster!

    redirect_to admin_daily_check_in_path(@school_day), notice: 'Roster refreshed from active registrations.'
  end

  def mark_all_present
    @school_day.attendance_entries.where(status: 'not_yet_reported').update_all(status: 'present', updated_at: Time.current)

    redirect_to admin_daily_check_in_path(@school_day), notice: 'All unreported students were marked present.'
  end

  def update_entry
    entry = @school_day.attendance_entries.find(params[:entry_id])
    entry.update!(status: params[:status], notes: params[:notes])

    redirect_to admin_daily_check_in_path(@school_day), notice: "Updated attendance for #{entry.student.full_name}."
  end

  def update_notice
    entry = @school_day.attendance_entries.find(params[:entry_id])
    attendance_notice = @school_day.attendance_notices.find_or_initialize_by(student_id: entry.student_id)
    attendance_notice.update!(kind: params[:notice_kind], status: params[:notice_status], notes: params[:notice_notes])

    redirect_to admin_daily_check_in_path(@school_day), notice: "Updated notice for #{entry.student.full_name}."
  end

  private

  def confirm_admin
    redirect_to root_path unless current_parent&.admin?
  end

  def set_school_day
    @school_day = SchoolDay.find(params[:id])
  end
end