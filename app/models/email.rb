# frozen_string_literal: true

class Email < Provider
  def send_notification(content:, user_id:)
    Sidekiq.logger.info "Sending email notification to user: #{user_id} with content: #{content}"
  end
end
