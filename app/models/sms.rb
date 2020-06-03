# frozen_string_literal: true

class Sms < Provider
  def send_notification(content:, user_id:)
    Sidekiq.logger.info "Sending sms notification to user: #{user_id} with content: #{content}"
  end
end
