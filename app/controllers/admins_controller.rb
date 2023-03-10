class AdminsController < ApplicationController
  before_action :confirm_admin

  def dashboard
  end

  def missing_documents
    parent_ids = Student.enrolled.pluck(:parent_id)

    @parents_and_missing_docs = []
    parent_ids.each do |pid|
      p = Parent.find(pid)
      parent_ary = [pid]
      
      missing_docs = []
      missing_docs << { student: nil, doc_title: ReleaseOfLiability.to_s.titleize } if p.release_of_liability.nil?
      missing_docs << { student: nil, doc_title: ParentAgreement.to_s.titleize } if p.parent_agreement.nil?
      missing_docs << { student: nil, doc_title: PhotoConsent.to_s.titleize } if p.photo_consent.nil?

      p.students.enrolled.each do |s|
        missing_docs << { student: s.full_name, doc_title: LearningDifferencesForm.to_s.titleize } if s.learning_differences_form.nil?
        missing_docs << { student: s.full_name, doc_title: MedicalForm.to_s.titleize } if s.medical_form.nil?
      end

      parent_ary << missing_docs
      @parents_and_missing_docs << parent_ary
    end
    
    @parents_and_missing_docs
  end

  def open_seats
    @q = Section.joins(:course).search(params[:q])
    @sections = @q.result
  end

  def student_schedule
    @student = Student.find(params[:student_id])
  end

  def students_schedules
  end
  
  private
  
  def confirm_admin     
    current_parent.has_role? :admin
  end
end