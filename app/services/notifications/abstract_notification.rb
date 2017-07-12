class Notifications::AbstractNotification
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  def initialize(*args)
    raise NotImplementedError
  end

  def notify
    raise NotImplementedError
  end

  attr_reader :to, :from
end
