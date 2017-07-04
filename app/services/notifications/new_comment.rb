class Notifications::NewComment < Notifications::AbstractNotification

  def initialize(comment)
    @comment = comment
    @to = comment.photo.album.user
    @from = comment.user
    @photo = comment.photo
  end

  def notify
    return if to == from
    NotificationsChannel.broadcast_to(to, {
      type: 'comment',
      data: {
        name: from.first_name,
        avatar: avatar(from),
        url: user_album_photo_path(to, photo.album, photo)
      }
    })
    NotificationsMailer.comment_notification(comment).deliver_later
  end

  attr_reader :photo, :comment
end
