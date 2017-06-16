class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user, -> (notification) do
      ActiveRecord::Base.connection_pool.with_connection do
        if ability.can? :read_notifications, current_user
          transmit ActiveSupport::JSON.decode(notification), via: current_user
        end
      end
    end
  end
end
