# frozen_string_literal: true

class Provider < ApplicationRecord
  PROVIDER_TYPES = %w[Email Sms PushNotification].freeze

  validates :name, :min_limit, presence: true
  validates :type, inclusion: { in: PROVIDER_TYPES, message: "provider type must be one of: #{PROVIDER_TYPES}" }
  validates :name, uniqueness: { case_sensitive: false }

  has_many :notifications

  def send_notifications(_user_notifications)
    raise 'Not implemented for this provider'
  end
end
