# frozen_string_literal: true

class Sms < Provider
  def send_notifications(_user_notifications)
    Rails.logger.info 'Sending sms notifications'
  end
end
