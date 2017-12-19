class StudentShadow < ActiveRecord::Base
  belongs_to :student
  belongs_to :shadow_spot

  validate :only_one_shadow_per_time_slot
  validate :student_may_only_shadow_one_day

  def only_one_shadow_per_time_slot
    # existing_ss = StudentShadow
    return if StudentShadow.where(shadow_spot: shadow_spot).empty?
    errors.add(:shadow_spot, "may only have one student at a time")
  end

  def student_may_only_shadow_one_day
    spots = StudentShadow.where(student:student)
    return true if spots.empty?
    if spots.count > 1
      errors.add(:student, "may not shadow more than twice")
    elsif
      if spots.select { |s| s.shadow_spot.date != shadow_spot.date }.empty?
        errors.add(:student, "may not shadow on separate dates")
      end
    end
  end
end
