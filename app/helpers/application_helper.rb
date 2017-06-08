module ApplicationHelper
  def avatar(user)
    @avatar ||= {}
    @avatar[user.id] ||= user.avatar? ? user.avatar.url : image_url('noavatar.png')
  end
end
