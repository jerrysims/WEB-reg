class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :street_address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  has_many :students

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
