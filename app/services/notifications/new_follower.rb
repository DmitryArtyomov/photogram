class Notifications::NewFollower < Notifications::AbstractNotification

  def initialize(followership)
    @to = followership.followed
    @from = followership.follower
  end

  def notify
    NotificationsChannel.broadcast_to(to, {
      type: 'follower',
      data: {
        name: from.first_name,
        avatar: avatar(from),
        url: user_path(from)
      }
    })
  end
end
