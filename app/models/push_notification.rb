# frozen_string_literal: true

class PushNotification < Provider
  def send_notification(content:, user_id:)
    # Integration code with the push_notification service
    Sidekiq.logger.info "Sending push notification to user: #{user_id} with content: #{content}"
  end
end
