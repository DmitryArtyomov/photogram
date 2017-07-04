class Notifications::NewFollower < Notifications::AbstractNotification

  def initialize(followership)
    @followership = followership
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
    NotificationsMailer.follower_notification(followership).deliver_later
  end

  attr_reader :followership
end
