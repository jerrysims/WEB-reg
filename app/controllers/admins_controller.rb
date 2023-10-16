class AdminsController < ApplicationController
  before_action :confirm_admin
  before_action :set_student, only: [:student_schedule]
  before_action :set_total_fees_and_tuition, only: [:student_schedule]

  add_breadcrumb "Home", :root_path

  def dashboard
  end

  def grades
    @sections = Section.all.select { |s| s.registrations.count > 0 }
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
        missing_docs << { student: s.full_name, doc_title: LearningDifferencesForm.to_s.titleize } if s.needs_learning_differences_link && s.learning_differences_form.nil?
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
  end

  def view_all_grades
    @sections = Section.all.includes(:course).order("courses.name asc")
  end

  def view_grades
    @section = Section.find(params[:section_id])
  end

  
  private
  
  def confirm_admin     
    current_parent.has_role? :admin
  end

  def set_student
    @student = Student.find(params[:student_id])
    @parent = @student.parent
  end

  def set_student_tuition_totals
    ary=[]
    @parent.students.each do |s|
      student_total = s.courses.inject(0) { |sum, e| sum + e.semester_tuition }
      ary << [ s.full_name, student_total ]
    end

    ary
  end

  def set_total_fees_and_tuition
    @parent_tuition_total = @parent.courses.inject(0){ |sum, e| sum + e.semester_tuition }
    @parent_total_course_fees = @parent.courses.inject(0){ |sum, e| sum + e.fee }
    @student_tuition_totals = set_student_tuition_totals
  end
end