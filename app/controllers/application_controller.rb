class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if request.referrer == new_user_session_url
      super
    else
      stored_location_for(resource) || request.referrer || profile_path(resource)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
