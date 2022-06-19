class ApplicationController < ActionController::Base
  before_action :configure_permmitted_parameters, if: :devise_controller?

  protected

  def configure_permmitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
