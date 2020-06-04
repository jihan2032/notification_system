# frozen_string_literal: true

require 'test_helper'

class UserNotificationsControllerTest < ActionDispatch::IntegrationTest
  def user_id
    users(:shadya).id
  end

  test 'valid index status when valid user_id' do
    get user_notifications_url, params: { user_id: user_id }
    assert_response :success
  end

  test 'invalid index status when invalid user_id' do
    get user_notifications_url, params: { user_id: 19283 }
    assert_response :not_found
  end

  test 'valid index response' do
    get user_notifications_url, params: { user_id: user_id }
    body = JSON.parse(@response.body)
    notification = body.first
    assert_equal %w[id notification_id user_id content lang_code notification_type] - notification.keys, []
  end

  test 'returning all user notifications' do
    get user_notifications_url, params: { user_id: user_id }
    user = User.find user_id
    body = JSON.parse(@response.body)
    assert_equal body.size, user.notifications.count
  end

  test 'returning notifications as the per param requested' do
    get user_notifications_url, params: { per: 1, user_id: user_id }
    body = JSON.parse(@response.body)
    assert_equal body.size, 1
  end
end
