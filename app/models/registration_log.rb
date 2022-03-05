class RegistrationLog < ApplicationRecord
  belongs_to :student
  belongs_to :section
  belongs_to :user, class_name: "Parent"
end
