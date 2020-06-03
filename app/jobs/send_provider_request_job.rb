# frozen_string_literal: true

class SendProviderRequestJob < ApplicationJob
  queue_as :providers

  def perform(provider_id:, content:, user_id:)
    provider = Provider.find(provider_id)
    provider.integrate_with_api(content: content, user_id: user_id)
  end
end
