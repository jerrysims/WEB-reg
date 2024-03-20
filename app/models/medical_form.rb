class MedicalForm < ApplicationRecord
  belongs_to :student
  validates_presence_of :emergency_contact_first_name,
                        :emergency_contact_last_name,
                        :emergency_contact_relationship,
                        :preferred_hospital,
                        :pain_reliever_permission,
                        :medical_care_consent,
                        :signature,
                        :student_id

  def status
    return "complete" if emergency_contact_first_name && 
                         emergency_contact_last_name && 
                         emergency_contact_relationship && 
                         preferred_hospital && 
                         pain_reliever_permission && 
                         medical_care_consent && 
                         signature && 
                         student_id
                         
    "incomplete"
  end
end
