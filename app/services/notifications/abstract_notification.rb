class Notifications::AbstractNotification
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  def initialize
    raise NotImplementedError
  end

  def notify
    raise NotImplementedError
  end

  protected
  attr_reader :to, :from
end
