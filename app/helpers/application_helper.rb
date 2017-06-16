module ApplicationHelper
  def avatar(user)
    @avatar ||= {}
    @avatar[user.id] ||= user.avatar? ? user.avatar.url : ActionController::Base.helpers.asset_path('noavatar.png')
  end
end
