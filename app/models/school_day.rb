class SchoolDay < ApplicationRecord
  has_many :attendance_entries, dependent: :destroy
  has_many :attendance_notices, dependent: :destroy

  validates :date, presence: true, uniqueness: true
  validates :day_name, presence: true

  def build_daily_roster!
    expected_student_ids.each do |student_id|
      entry = attendance_entries.find_or_initialize_by(student_id: student_id)
      entry.status = 'not_yet_reported' if entry.new_record?
      entry.save!
    end
  end

  private

  def expected_student_ids
    registrations = Registration
      .joins(section: :course)
      .where(status: Registration::STATUSES)
      .where(sections: { day: [day_name, 'Tuesday/Thursday'] })

    registration_period_id = RegistrationPeriod::CURRENT_ACADEMIC_YEAR.id
    registrations = registrations.where(courses: { registration_period_id: registration_period_id })

    registrations.distinct.pluck(:student_id)
  end
end
