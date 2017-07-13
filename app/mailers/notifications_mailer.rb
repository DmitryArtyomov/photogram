class NotificationsMailer < ApplicationMailer
  default from: "notifications@#{ENV['PRODUCTION_HOST'] || 'photogram.net'}"

  def follower_notification(followership)
    @follower = followership.follower
    @to = followership.followed
    mail(to: @to.email, subject: "#{@follower.first_name} #{@follower.last_name} is now following you")
  end

  def comment_notification(comment)
    @comment = comment
    @commenter = @comment.user
    @to = @comment.photo.album.user
    return if @commenter == @to
    mail(to: @to.email, subject: "#{@commenter.first_name} #{@commenter.last_name} left a comment on your photo")
  end
end
