# frozen_string_literal: true

require 'test_helper'

class Dashboard::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test 'valid index status' do
    get dashboard_notifications_url, headers: admin_headers
    assert_response :success
  end

  test 'returning all notifications' do
    get dashboard_notifications_url, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body.size, Notification.count
  end

  test 'returning notifications as the per param requested' do
    get dashboard_notifications_url, params: { per: 1 }, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body.size, 1
  end

  test 'valid index response' do
    get dashboard_notifications_url, headers: admin_headers
    body = JSON.parse(@response.body)
    notification = body.first
    assert_equal %w[id provider_id texts default_lang kind] - notification.keys, []
  end

  test 'valid create status' do
    post dashboard_notifications_url, params: notification_params, headers: admin_headers
    assert_response :created
  end

  test 'valid create response' do
    post dashboard_notifications_url, params: notification_params, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal %w[id provider_id texts default_lang kind] - body.keys, []
  end

  test 'create status in case of invalid params' do
    post dashboard_notifications_url, params: invalid_notification_params, headers: admin_headers
    assert_response :unprocessable_entity
  end

  test 'create response in case of invalid params' do
    post dashboard_notifications_url, params: invalid_notification_params, headers: admin_headers
    body = JSON.parse(@response.body)
    assert_equal body.keys, ['texts']
  end

  test 'index action authorization' do
    get dashboard_notifications_url, headers: invalid_admin_headers
    assert_response :unauthorized
  end

  test 'create action authorization' do
    post dashboard_notifications_url, params: notification_params, headers: invalid_admin_headers
    assert_response :unauthorized
  end

  def notification_params
    {
      notification: {
        provider_id: Provider.first.id,
        texts: { en: 'Surprise new promo code...', ar: 'الحق العرض' },
        default_lang: 'en',
        kind: 'personalized'
      }
    }
  end

  def invalid_notification_params
    {
      notification: {
        provider_id: Provider.first.id,
        default_lang: 'en',
        kind: 'personalized'
      }
    }
  end
end
