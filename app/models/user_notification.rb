# frozen_string_literal: true

class UserNotification < ApplicationRecord
  validates :content, :lang_code, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :notification, counter_cache: true
end
