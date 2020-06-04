# frozen_string_literal: true

class FireNotificationJob < ApplicationJob
  queue_as :notifications

  def perform(provider:, content:, user_id:)
    provider.integrate_with_api(content: content, user_id: user_id)
  end
end
