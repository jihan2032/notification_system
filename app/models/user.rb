# frozen_string_literal: true

class User < ApplicationRecord
  validates :phone, :email, uniqueness: { case_sensitive: false }

  belongs_to :language, counter_cache: true
  has_many :user_notifications

  def notifications
    user_notifications.where(notification_type: Provider.in_app_notification_types).order(created_at: :desc)
  end
end
