# frozen_string_literal: true

class CreateNotificationsJob < ApplicationJob
  queue_as :default

  def perform(notification:, user_ids:)
    users = User.where(id: user_ids)
    user_notifications = []
    users.each do |user|
      user_notifications << construct_notification(notification, user)
    end
    UserNotification.insert_all!(user_notifications)
    notification.provider.fire_requests(user_notifications)
  end

  def construct_notification(notification, user)
    notification.construct(user).merge(
      provider_id: notification.provider.id,
      notification_type: notification.provider.type,
      notification_id: notification.id,
      user_id: user.id,
      created_at: Time.current,
      updated_at: Time.current
    )
  end
end
