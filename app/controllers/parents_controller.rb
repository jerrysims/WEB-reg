class ParentsController < ApplicationController
  before_action :authenticate_parent!
  before_action :check_for_locked_parent, except: [:registration_home, :view_grades]
  before_action :set_parent
  before_action :set_rp, only: [:view_grades]
  before_action :set_open_rps

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
  end

  def show
    redirect_to parent_confirm_grade_path(current_parent.id) if should_redirect_to_confirm_grade?
    redirect_to parent_confirm_web_email_path(current_parent.id) if should_confirm_web_email?

    @students = current_parent.students
  end

  def view_grades
    @students = current_parent.students.enrolled(@rp)
  end

  private
  def build_email_suggestions(student)
    suggestions = []
    f = student.first_name.downcase.strip
    l = student.last_name.downcase.strip
    n = student.nickname.nil? ? nil : student.nickname.downcase.strip
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

  def set_open_rps
    @open_rps = RegistrationPeriod.open
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def set_parent
    @parent = current_parent
  end

  def should_confirm_web_email?
    current_parent.students.enrolled(@rp).missing_web_email.count > 0 ||
    current_parent.students.enrolled(@rp).web_email_different_domain.count > 0
  end

  def should_redirect_to_confirm_grade?
    current_parent.students.unconfirmed.count > 0
  end

  def should_see_covid_statement?
    !current_parent.covid_statement_acknowledged?
  end
end
