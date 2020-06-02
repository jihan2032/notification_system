# frozen_string_literal: true

class EmailProvider < Provider
  def send_notifications(_user_notifications)
    Rails.logger.info 'Sending email notifications'
  end
end
