# frozen_string_literal: true

class User < ApplicationRecord
  validates :phone, :email, uniqueness: { case_sensitive: false }

  belongs_to :language, counter_cache: true
  has_many :user_notifications

  def notifications
    user_notifications.order(created_at: :desc)
  end
end
