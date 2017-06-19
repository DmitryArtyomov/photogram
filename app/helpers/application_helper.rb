module ApplicationHelper
  def avatar(user)
    user.avatar? ? user.avatar.url : ActionController::Base.helpers.asset_path('noavatar.png')
  end
end
