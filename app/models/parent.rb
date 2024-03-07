class Parent < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # These validation should run as soon as a user creates an account
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

  # TODO: The following need to be implemented
  # These validations should run when the user tries to sign a student up for classes
  validates :street_address_1, presence: true, on: :course_registration
  validates :city, presence: true, on: :course_registration
  validates :state, presence: true, on: :course_registration
  validates :zip_code, presence: true, on: :course_registration

  has_many :students
  # has_many :registrations, through: :students
  has_many :courses, through: :students
  has_many :invoice_line_items
  has_one :invoice
  has_one :parent_agreement
  has_one :photo_consent
  has_one :release_of_liability
  has_many :receipts

  scope :missing_invoice, -> { left_outer_joins(:invoice).where.not(id: Invoice.closed.pluck(:parent_id)) }
  scope :locked, -> { where(locked: true) }
  scope :have_not_gotten_missing_forms_mail, -> { Parent.includes(:receipts).where(receipts: { form_name: nil }) }

  after_create :assign_default_role

  def assign_default_role
    self.add_role("active") if self.roles.blank?
  end

  def enrolled_students_count(rp)
    students.enrolled(rp).count
  end

  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def invoice_closed?
    invoice.present? && invoice.closed?
  end

  def is_returning?
    return false
    students.enrolled.count > 0
  end

  def registered_students(rp)
    students.includes(registrations: { section: { course: :registration_period } })
            .where(registrations: { sections: { courses: { registration_period_id: rp.id } } })
  end

  def rp_courses(rp)
    courses.where(registration_period_id: rp.id)
  end

  def send_confirmation(invoice)
    ConfirmationMailer.registration_confirmation_email(self, invoice).deliver_now
  end
end
