# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    users(:shadya)
  end

  test 'phone uniqueness' do
    u1 = user
    u2 = users(:sabah)
    u1.phone = u2.phone
    assert_not u1.valid?
  end

  test 'email uniqueness' do
    u1 = user
    u2 = users(:sabah)
    u1.email = u2.email
    assert_not u1.valid?
  end

  test 'notifications method output includes in-app notifications' do
    u1 = user
    notifications = u1.notifications
    assert_equal notifications.map(&:notification_type).uniq - Provider.in_app_notification_types, []
  end

  test 'notifications method output exclude sms/email/etc notifications' do
    u1 = user
    user_notifications = u1.user_notifications
    notifications = u1.notifications
    assert (user_notifications.map(&:notification_type).uniq - notifications.map(&:notification_type).uniq).any?
  end

  test 'notifications method sort by time desc' do
    u1 = user
    user_not1 = u1.notifications.first
    user_not1.dup.save
    assert u1.notifications.first.created_at > u1.notifications.second.created_at
  end
end
