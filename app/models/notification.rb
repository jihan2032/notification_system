# frozen_string_literal: true

class Notification < ApplicationRecord
  NOTIFICATION_TYPES = %w[group personalized].freeze

  validates :texts, presence: true
  validates :kind, inclusion: { in: NOTIFICATION_TYPES }

  belongs_to :provider
  has_many :user_notifications
end
