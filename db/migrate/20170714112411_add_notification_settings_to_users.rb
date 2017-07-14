class AddNotificationSettingsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :follower_email_notification, :boolean, default: true
    add_column :users, :comment_email_notificaton, :boolean, default: true
  end
end
