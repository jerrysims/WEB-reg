class Admin::DailyCheckInsController < ApplicationController
  before_action :authenticate_admin_or_teacher!
  skip_before_action :authenticate_admin_or_teacher!, only: [:kiosk]
  skip_before_action :authenticate_parent!, only: [:kiosk]
  before_action :set_school_day, only: [:show, :build_roster, :update_entry, :update_notice]

  def index
    @school_days = SchoolDay.includes(:attendance_notices, attendance_entries: :student).order(date: :asc)
    @today = Date.current
    @future_school_days = @school_days.select { |school_day| school_day.date >= @today }
    @past_school_days = @school_days.select { |school_day| school_day.date < @today }
  end

  def show
    @attendance_entries = @school_day.attendance_entries.includes(:student).order('students.last_name ASC').references(:students)
    @attendance_notices_by_student_id = @school_day.attendance_notices.index_by(&:student_id)
    @kiosk_mode = false
  end

  def kiosk
    @school_day = SchoolDay.find_or_create_for!(Date.current)
    @school_day.build_daily_roster!

    @attendance_entries = @school_day.attendance_entries.includes(:student).order('students.last_name ASC').references(:students)
    @attendance_notices_by_student_id = @school_day.attendance_notices.index_by(&:student_id)
    @kiosk_mode = true

    render 'show', layout: false
  end

  def start_today
    school_day = SchoolDay.find_by(date: Date.current)

    unless school_day
      redirect_to admin_daily_check_ins_path, alert: "Today is not a SchoolDay, so check-in was not opened."
      return
    end

    school_day.build_daily_roster!

    redirect_to admin_daily_check_in_path(school_day), notice: "Daily check-in opened for #{school_day.date.strftime('%A, %b %-d')}"
  end

  def build_roster
    @school_day.build_daily_roster!

    redirect_to admin_daily_check_in_path(@school_day), notice: 'Roster refreshed from active registrations.'
  end

  def update_entry
    entry = @school_day.attendance_entries.find(params[:entry_id])
    entry.update!(status: params[:status])

    redirect_to admin_daily_check_in_path(@school_day, saved_entry_id: entry.id)
  end

  def update_notice
    entry = @school_day.attendance_entries.find(params[:entry_id])
    attendance_notice = @school_day.attendance_notices.find_or_initialize_by(student_id: entry.student_id)
    attendance_notice.update!(kind: params[:notice_kind], status: params[:notice_status], notes: params[:notice_notes])

    redirect_to admin_daily_check_in_path(@school_day, saved_entry_id: entry.id)
  end

  private

  def set_school_day
    @school_day = SchoolDay.find(params[:id])
  end
end