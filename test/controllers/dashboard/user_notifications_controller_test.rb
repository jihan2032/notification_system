# frozen_string_literal: true

require 'test_helper'

class UserNotificationsControllerTest < ActionDispatch::IntegrationTest
  test 'valid create status' do
    post dashboard_user_notifications_url, params: params, headers: admin_headers
    assert_response :created
  end

  test 'valid create response' do
    post dashboard_user_notifications_url, params: params, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body, { 'message' => 'Sending notifications to users...' }
  end

  test 'create status in case of params_missing_notification_id' do
    post dashboard_user_notifications_url, params: params_missing_notification_id, headers: admin_headers
    assert_response :unprocessable_entity
  end

  test 'create response in case of params_missing_notification_id' do
    post dashboard_user_notifications_url, params: params_missing_notification_id, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body.keys, ['notification']
  end

  test 'create status in case of params_missing_user_ids' do
    post dashboard_user_notifications_url, params: params_missing_user_ids, headers: admin_headers
    assert_response :unprocessable_entity
  end

  test 'create response in case of params_missing_user_ids' do
    post dashboard_user_notifications_url, params: params_missing_user_ids, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body.keys, ['user_ids']
  end

  test 'create action authorization' do
    post dashboard_user_notifications_url, params: params, headers: invalid_admin_headers
    assert_response :unauthorized
  end

  def params
    {
      user_notification: {
        notification_id: Notification.first.id,
        user_ids: User.all.map(&:id)
      }
    }
  end

  def params_missing_notification_id
    {
      user_notification: {
        user_ids: User.all.map(&:id)
      }
    }
  end

  def params_missing_user_ids
    {
      user_notification: {
        notification_id: Notification.first.id
      }
    }
  end
end
