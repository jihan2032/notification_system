# frozen_string_literal: true

class PushNotification < Provider
  def send_notifications(_user_notifications)
    Rails.logger.info 'Sending push notifications'
  end
end
