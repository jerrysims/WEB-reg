class Registration < ActiveRecord::Base

  belongs_to :section
  belongs_to :student
  has_one :course, through: :section
  belongs_to :user, class_name: "Parent"

  validates :student, presence: true
  validate :section_has_not_reached_max
  validate :no_other_sections_in_session
  validate :one_class_at_a_time
  validate :student_is_correct_grade

  scope :missing_invoices, -> { where(student: Student.where(parent_id: Parent.left_outer_joins(:invoice).where.not(id: Invoice.closed.pluck(:parent_id)))) }

  before_save :log_registration
  before_destroy :log_registration
  after_destroy :generate_dropped_course_line_items

  private

  def generate_dropped_course_line_items
    return nil unless status == "confirmed"

    @invoice = Invoice.find_or_create_by(parent: student.parent)

    InvoiceLineItem.create(
      product: Product::DROPPED_COURSE_FEE,
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
    other_registrations = student.registrations - [self]
    binding.pry

    unless other_registrations.select { |r| r.section.start_time == section.start_time && (r.section.day == section.day || r.section.day == "Tuesday/Thursday" || section.day == "Tuesday/Thursday")}.empty?
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

  private

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
