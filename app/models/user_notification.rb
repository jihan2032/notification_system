# frozen_string_literal: true

class UserNotification < ApplicationRecord
  NOTIFICATION_TYPES = Provider.provider_types

  validates :content, :lang_code, presence: true
  validates :notification_type, inclusion: { in: NOTIFICATION_TYPES, message: "notification type must be one of: #{NOTIFICATION_TYPES}" }

  belongs_to :user, counter_cache: true
  belongs_to :notification, counter_cache: true
  belongs_to :provider, counter_cache: true
end
