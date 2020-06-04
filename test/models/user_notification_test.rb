# frozen_string_literal: true

require 'test_helper'

class UserNotificationTest < ActiveSupport::TestCase
  def user_notification
    user_notifications(:sms_user_notification)
  end

  test 'valid provider' do
    assert user_notification.valid?
  end

  test 'content presence' do
    not1 = user_notification
    not1.content = nil
    assert_not not1.valid?
  end

  test 'lang_code presence' do
    not1 = user_notification
    not1.lang_code = nil
    assert_not not1.valid?
  end

  test 'notification_type presence' do
    not1 = user_notification
    not1.notification_type = nil
    assert_not not1.valid?
  end

  test 'notification_type value inclusion' do
    not1 = user_notification
    not1.notification_type = 'Dummy value'
    assert_not not1.valid?
  end
end
