# frozen_string_literal: true

require 'test_helper'

class FireNotificationJobTest < ActiveJob::TestCase
  test 'integrating with the provider api' do
    notification = Notification.first
    provider = notification.provider
    assert_difference -> { provider.last_min_count } => 1 do
      FireNotificationJob.perform_now(provider: provider, content: 'Some content', user_id: User.first.id)
    end
  end
end
