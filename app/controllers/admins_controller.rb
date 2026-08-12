class AdminsController < ApplicationController
  before_action :confirm_admin, except: [:student_profile, :students_schedules]
  before_action :confirm_admin_or_teacher, only: [:student_profile, :students_schedules]
  before_action :set_student, only: [:student_schedule, :student_profile]
  before_action :set_rp, only: [:grades, :missing_documents, :student_schedule, :students_schedules, :view_all_grades]
  before_action :set_other_rps, only: [:grades, :view_all_grades]
  before_action -> { set_total_fees_and_tuition(@rp) }, only: [:student_schedule]


  add_breadcrumb "Home", :root_path

  def dashboard
  end

  def edit_grades
    @section = Section.find(params[:section_id])

    if current_parent.is_a?(Teacher) || current_parent.has_role?(:admin)
      redirect_to teacher_section_gradebook_path(teacher_id: current_parent.id, section_id: @section.id)
    else
      flash[:notice] = "This account does not have Teacher privileges"
      redirect_back fallback_location: admin_grades_path
    end
  end

  def grades
    @sections = Section.in_period(@rp).select { |s| s.registrations.count > 0 }
  end

  def missing_documents
    parent_ids = Student.enrolled(@rp).pluck(:parent_id)

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
    @q = Section.in_period(RegistrationPeriod::CURRENT_RP).joins(:course).search(params[:q])
    @sections = @q.result
  end

  def student_schedule
  end

  def student_profile
    @current_academic_period = RegistrationPeriod::CURRENT_ACADEMIC_YEAR || RegistrationPeriod.academic.order(open_date: :desc).first
    @attendance_totals = attendance_totals_for_current_period
    @current_registrations = current_period_registrations

    @tuesday_schedule = @current_academic_period.present? ? @student.daily_schedule("Tuesday", @current_academic_period) : []
    @thursday_schedule = @current_academic_period.present? ? @student.daily_schedule("Thursday", @current_academic_period) : []

    additional_contact = @student.additional_contacts.order(:created_at).first
    @other_parent_name = [additional_contact&.first_name, additional_contact&.last_name].compact.join(" ").strip
    @other_parent_name = "Not provided" if @other_parent_name.blank?

    @address = [@parent.street_address_1, @parent.street_address_2, @parent.city, @parent.state, @parent.zip_code].reject(&:blank?).join(", ")
  end

  def students_schedules
    @rp = RegistrationPeriod.academic.order(open_date: :desc).first || RegistrationPeriod::CURRENT_RP
  end

  def view_all_grades
    @sections = Section.in_period(@rp)
                       .joins(:course)
                       .where(courses: { show_in_gradebook: true })
                       .includes(:course)
                       .order("courses.name asc")
  end

  def view_grades
    @section = Section.find(params[:section_id])
  end

  
  private
  
  def confirm_admin
    current_parent.admin?
  end

  def confirm_admin_or_teacher
    current_parent.admin? || current_parent.is_a?(Teacher)
  end

  def set_other_rps
    return if @rp.nil? 

    @other_rps = RegistrationPeriod.where.not(id: @rp.id).where(rp_type: "academic")
  end
  
  def set_rp
    return @rp = RegistrationPeriod::CURRENT_RP if params[:registration_period_id].nil?

    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end
  
  def set_student
    @student = Student.find(params[:student_id])
    @parent = @student.parent
  end

  def set_student_tuition_totals
    ary=[]
    @parent.students.each do |s|
      student_total = s.rp_courses(@rp).inject(0) { |sum, e| sum + e.semester_tuition }
      ary << [ s.full_name, student_total ]
    end

    ary
  end

  def set_total_fees_and_tuition(rp)
    @parent_tuition_total = @parent.rp_courses(rp).inject(0){ |sum, e| sum + e.semester_tuition }
    @parent_total_course_fees = @parent.courses.inject(0){ |sum, e| sum + e.fee }
    @student_tuition_totals = set_student_tuition_totals
  end

  def attendance_totals_for_current_period
    return {} if @current_academic_period.nil?

    date_range = @current_academic_period.open_date..@current_academic_period.close_date
    AttendanceEntry.joins(:school_day)
                   .where(student_id: @student.id, school_days: { date: date_range })
                   .group(:status)
                   .count
  end

  def current_period_registrations
    return Registration.none if @current_academic_period.nil?

    Registration.joins(section: :course)
                .includes(:quarterly_scores, section: :course)
                .where(student_id: @student.id,
                       status: Registration::STATUSES,
                       courses: { registration_period_id: @current_academic_period.id })
                .order("sections.day ASC, sections.start_time ASC")
  end
end