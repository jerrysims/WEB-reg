class ParentsController < ApplicationController
  before_action :authenticate_parent!
  before_action :check_for_locked_parent, except: [:registration_home, :view_grades]
  before_action :set_parent
  before_action :set_rp, only: [:show, :locked_landing]
  before_action :set_open_rps
  before_action :set_enrollment_forms, only: [:locked_landing, :show]
  before_action :set_student_forms, only: [:locked_landing, :show]
  before_action :should_not_show_enrollment_forms, only: [:show]

  def acknowledge_covid_statement
    current_parent.update_attributes(covid_statement_acknowledged: true)

    redirect_to root_path
  end

  def confirm_grade
    @unconfirmed_students = current_parent.students.unconfirmed
  end

  def confirm_web_email
    @students = populate_email_suggestions
  end

  def covid_statement
  end

  def locked_landing
    @dont_show_header = true
  end

  def show
    @dont_show_header = true
    redirect_to parent_confirm_grade_path(current_parent.id) if should_redirect_to_confirm_grade?
    redirect_to parent_confirm_web_email_path(current_parent.id) if should_confirm_web_email?

    @students = current_parent.students
  end

  def view_grades
    @rp = RegistrationPeriod::CURRENT_ACADEMIC_YEAR
    @students = current_parent.students.enrolled(@rp)
    @registrations = Registration.joins(section: { course: :registration_period })
                                 .where(student: @students)
                                 .where("registration_periods.id": @rp.id)
                                 .where(sections: { published: true })
  end

  private
  def build_email_suggestions(student)
    suggestions = []
    f = student.first_name.downcase.strip
    l = student.last_name.downcase.strip
    n = student.nickname.nil? || student.nickname.strip.empty? ? nil : student.nickname.downcase.strip
    suggestions << "#{f}.#{l}@webtutorialnashville.com"
    suggestions << "#{n}.#{l}@webtutorialnashville.com" unless n.nil?
    suggestions
  end

  def populate_email_suggestions
    students = []
    (current_parent.students.missing_web_email + current_parent.students.web_email_different_domain).each do |s|
      student = {}
      student[:student] = s
      student[:suggestions] = build_email_suggestions(s)
      students << student
    end
    students
  end

  def set_enrollment_forms
    @parent_agreement = ParentAgreement.find_by(parent_id: current_parent.id, registration_period_id: @rp.id)
    @photo_consent = PhotoConsent.find_by(parent_id: current_parent.id, registration_period_id: @rp.id)
    @release_of_liability = ReleaseOfLiability.find_by(parent_id: current_parent.id, registration_period_id: @rp.id)
  end

  def set_open_rps
    @open_rps = RegistrationPeriod.open
  end

  def set_rp
    return @rp = RegistrationPeriod::CURRENT_RP if params[:registration_period_id].nil?

    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def set_parent
    @parent = current_parent
  end

  def set_student_forms
    @student_forms = []
    current_parent.students.enrolled(@rp).each do |s|
      medical_form = MedicalForm.find_by(student_id: s.id, registration_period_id: @rp.id) 
      @student_forms << [s, medical_form]
    end

    @student_forms
  end

  def should_confirm_web_email?
    current_parent.students.enrolled(@rp).missing_web_email.count > 0 ||
    current_parent.students.enrolled(@rp).web_email_different_domain.count > 0
  end

  def should_not_show_enrollment_forms
    @should_not_show_enrollment_forms = !current_parent.students.enrolled(@rp).count
  end

  def should_redirect_to_confirm_grade?
    current_parent.students.unconfirmed.count > 0
  end

  def should_see_covid_statement?
    !current_parent.covid_statement_acknowledged?
  end
end
