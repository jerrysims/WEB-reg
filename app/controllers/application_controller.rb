class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_parent!

  rescue_from SecurityError do |exception|
    flash[:notice] = "You are not authorized to view that page"
    redirect_to root_url
  end
  # before_filter :check_for_locked_parent

  alias_method :current_user, :current_parent

  protect_from_forgery with: :exception

  def authenticate_admin_user!
    return if current_user.has_role?(:admin)

    raise SecurityError
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :email,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :phone_number
      )
    end
  end


  # def check_for_locked_parent
  #   unless params[:controller] == "devise/sessions" || ["review", "destroy"].include?(params[:action])
  #     if current_parent.locked
  #       redirect_to controller: "registrations", action: "review", student_id: current_parent.students.first.id
  #     end
  #   end
  # end

  # def current_admin_user
  #   current_parent
  # end
  #
  # def current_user
  #   current_parent
  # end
end
