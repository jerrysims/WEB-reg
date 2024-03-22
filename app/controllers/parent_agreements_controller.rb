class ParentAgreementsController < ApplicationController
  before_action :set_parent
  before_action :set_student, except: [:update]
  before_action :set_rp
  before_action :set_read_only, only: [:show]
  before_action :dont_show_header

  def create
    @parent_agreement = ParentAgreement.new(parent_agreement_params)
    if @parent_agreement.save!
      flash[:notice] = "Parent Agreement successfully saved"
      render :show
    else
      flash[:warning] = "There was an error saving the agreement"
      render :new
    end
  end

  def edit 
    @form_action = :update
    @parent_agreement = ParentAgreement.find(params[:id])
  end

  def new
    @form_action = :create
    @parent_agreement = ParentAgreement.new
  end
  
  def show
    @parent_agreement = ParentAgreement.find(params[:id])
  end

  def update
    @parent_agreement = ParentAgreement.find params[:id]

    if @parent_agreement.update parent_agreement_params
      flash[:notice] = "Parent Agreement successfully updated"
      redirect_to root_path
    else 
      flash[:alert] = "Form could not be updated. Please ensure all required fields are completed"
      redirect_back fallback_location: edit_parent_registration_period_parent_agreement_path(
        parent_id: @parent.id, 
        registration_period_id: @rp.id,
        id: @parent_agreement.id
      )
    end
  end

  private
  def dont_show_header
    @dont_show_header = params[:dont_show_header]
  end

  def param_label
    param_label = current_parent.class.to_s.downcase.to_sym
  end

  def set_parent
    @parent = current_parent
  end

  def set_read_only
    @read_only = true
  end

  def set_rp
    @rp = RegistrationPeriod.find(params[:registration_period_id])
  end

  def set_student
    unless action_name == "create"
      @student = Student.find(params[:student_id]) || current_parent.students.first
    else
      @student = Student.find(params[:parent_agreement][:student_id])
    end
  end

  def parent_agreement_params
    params.require(:parent_agreement).permit(
      :agree_to_pay, 
      :late_fee_acknowledgment, 
      :no_refund_on_voluntary_withdraw,
      :prorate_on_requested_withdraw,
      :plan_to_volunteer,
      :late_fee_for_late_pickup,
      :homeschool_registration,
      :signature,
      :registration_period_id,
      :parent_id
    )
  end

  def parent_params
    params.require(:parent_agreement).require(param_label).permit(:id, :first_name, :last_name)
  end
end
