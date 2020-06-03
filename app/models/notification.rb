# frozen_string_literal: true

class Notification < ApplicationRecord
  NOTIFICATION_TYPES = %w[group personalized].freeze

  validates :kind, inclusion: { in: NOTIFICATION_TYPES }
  validates :texts, :default_lang, presence: true
  validate :language_codes
  validate :default_text

  belongs_to :provider
  has_many :user_notifications

  def language_codes
    # validates that texts-hash keys are valid language codes
    return if (texts.with_indifferent_access.keys - Language.pluck(:code)).empty?

    errors.add(:texts, 'contains invalid language codes')
  end

  def default_text
    # validates the presence of the default langugae text
    default_text = texts.with_indifferent_access[default_lang]
    return if default_text.present?

    errors.add(:texts, 'missing the default language translation')
  end
end
