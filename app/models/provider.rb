# frozen_string_literal: true

class Provider < ApplicationRecord
  PROVIDER_TYPES = %w[Email Sms PushNotification].freeze
  IN_APP_TYPES = %w[PushNotification].freeze

  validates :name, :min_limit, presence: true
  validates :type, inclusion: { in: PROVIDER_TYPES, message: "provider type must be one of: #{PROVIDER_TYPES}" }
  validates :name, uniqueness: { case_sensitive: false }

  has_many :notifications

  def self.in_app_notification_types
    IN_APP_TYPES
  end

  def self.provider_types
    PROVIDER_TYPES
  end

  def send_notification(*)
    raise 'Not implemented for this provider'
  end

  def fire_requests(user_notifications)
    user_notifications.each do |user_notification|
      FireNotificationJob.perform_later(
        provider: self,
        content: user_notification[:content],
        user_id: user_notification[:user_id]
      )
    end
  end

  def integrate_with_api(content:, user_id:)
    if last_sync && Time.current - last_sync < 60
      check_api_limit_per_min(content: content, user_id: user_id)
    else
      send_api_request(content: content, user_id: user_id, requests_count: 1)
    end
  end

  private

  def check_api_limit_per_min(content:, user_id:)
    if last_min_count < min_limit
      send_api_request(content: content, user_id: user_id, requests_count: last_min_count + 1)
    else
      FireNotificationJob.set(wait: 60.seconds).perform_later(provider: self, content: content, user_id: user_id)
    end
  end

  def send_api_request(content:, user_id:, requests_count:)
    update_api_params(requests_count)
    send_notification(content: content, user_id: user_id)
  end

  def update_api_params(requests_count)
    update(last_sync: Time.current, last_min_count: requests_count)
  end
end
