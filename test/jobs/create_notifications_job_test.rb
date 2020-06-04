# frozen_string_literal: true

require 'test_helper'

class CreateNotificationsJobTest < ActiveJob::TestCase
  test 'successful bulk insersion for user_notifications' do
    notification = Notification.first
    user_ids = User.all.map(&:id)
    assert user_ids.count > 0
    assert_difference 'UserNotification.count', user_ids.count do
      CreateNotificationsJob.perform_now(notification: notification, user_ids: user_ids)
    end
  end
end
