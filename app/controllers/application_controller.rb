class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if request.referrer == new_user_session_url
      super
    else
      stored_location_for(resource) || request.referrer || user_path(resource)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer || root_path
  end

  def access_denied(param)
    flash[:danger] = "You cannot access this page"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :address, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
