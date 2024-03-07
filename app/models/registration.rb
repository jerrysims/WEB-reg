class Registration < ActiveRecord::Base

  STATUSES = %w(selected pending confirmed)

  belongs_to :section
  belongs_to :student
  has_one :course, through: :section
  belongs_to :user, class_name: "Parent"

  validates :student, presence: true
  validates :section, presence: true
  validate :section_has_not_reached_max
  validate :no_other_sections_in_session
  validate :one_class_at_a_time
  validate :student_is_correct_grade
  validates :status, inclusion: { in: STATUSES }

  nilify_blanks before: :update

  scope :missing_invoices, -> { where(student: Student.where(parent_id: Parent.left_outer_joins(:invoice).where.not(id: Invoice.closed.pluck(:parent_id)))) }

  before_save :log_registration
  before_destroy :log_registration
  after_destroy :generate_dropped_course_line_items

  def s1_average
    temp_array = []
    [:q1_grade, :q2_grade].each do |q|
      unless send(q).nil?
        temp_array << send(q).to_f
      end
    end

    return "-" if temp_array.empty?

    temp_array.inject(0.0) { |sum, el| sum + el }.to_f / temp_array.size
  end
  
  def s2_average
    temp_array = []
    [:q3_grade, :q4_grade].each do |q|
      unless send(q).nil?
        temp_array << send(q).to_f
      end
    end

    return "-" if temp_array.empty?

    temp_array.inject(0.0) { |sum, el| sum + el }.to_f / temp_array.size
  end

  private

  def generate_dropped_course_line_items
    return nil unless status == "confirmed"

    @invoice = Invoice.find_or_create_by(parent: student.parent)

    InvoiceLineItem.create(
      product: Product.dropped_course_fee(@rp),
      invoice: @invoice,
      parent: student.parent,
      quantity: section.course.fee
    )
  end

  def section_has_not_reached_max
    if section && section.at_max?
      errors.add(:section, "is full")
    end
  end

  def no_other_sections_in_session
    return if student.nil? || student.registrations.empty?
    student.registrations.each do |r|
      errors.add(:student, "has a class in session at that time") if section.conflicts_with r.section
    end
  end

  def one_class_at_a_time
    return false if student.nil? || section.nil?

    other_registrations = student.registrations - [self]
    unless other_registrations.select { |r| r.section.start_time == section.start_time && 
                                            r.section.course.registration_period == section.course.registration_period &&
                                           (r.section.day == section.day || r.section.day == "Tuesday/Thursday" || section.day == "Tuesday/Thursday")
                                      }.empty?
      errors.add(:student, "already has a class at that time")
    end
  end

  def self.ransackable_scopes(_auth_object = nil)
    %i[missing_invoices]
  end

  def student_is_correct_grade
    unless section && section.grades.split(",").include?(student.grade.to_s)
      errors.add(:student, "is not in the right grade for that section")
    end
  end

  def log_registration
    RegistrationLog.create(
      student: student,
      section: section,
      previous_status: self.changes[:status].nil? ? self.status : self.changes[:status].first,
      new_status: self.changes[:status].nil? ? self.status : self.changes[:status].last,
      user: self.user
    )
  end
end
