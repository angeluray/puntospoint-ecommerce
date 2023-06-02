class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name type address username role_level
                                               password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name type address username role_level
                                               password_confirmation])
  end
end
