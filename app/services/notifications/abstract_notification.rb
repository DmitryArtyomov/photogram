class Notifications::AbstractNotification
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  def notify
    raise NotImplementedError
  end

  attr_reader :to, :from
end
