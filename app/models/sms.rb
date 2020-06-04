# frozen_string_literal: true

class Sms < Provider
  def send_notification(content:, user_id:)
    # Integration code with the sms provider
    Sidekiq.logger.info "Sending sms notification to user: #{user_id} with content: #{content}"
  end
end
