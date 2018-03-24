class Parent < ActiveRecord::Base
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
  has_many :invoice_line_items

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
