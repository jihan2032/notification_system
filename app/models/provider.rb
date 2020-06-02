# frozen_string_literal: true

class Provider < ApplicationRecord
  PROVIDER_TYPES = %w[email sms push_notification].freeze

  validates :name, :min_limit, presence: true
  validates :type, inclusion: { in: PROVIDER_TYPES }
  validates :name, uniqueness: true

  has_many :notifications

  def send_notifications(_user_notifications)
    raise 'Not implemented for this provider'
  end
end
