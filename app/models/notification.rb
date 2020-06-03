# frozen_string_literal: true

class Notification < ApplicationRecord
  NOTIFICATION_TYPES = %w[group personalized].freeze

  validates :kind, inclusion: { in: NOTIFICATION_TYPES, message: "notification kind must be one of: #{NOTIFICATION_TYPES}" }
  validates :texts, :default_lang, presence: true
  validate :language_codes, if: -> { texts.present? }
  validate :default_text, if: -> { texts.present? }

  scope :list, -> { order(created_at: :desc) }

  belongs_to :provider
  has_many :user_notifications

  def language_codes
    # validates that texts-hash keys are valid language codes
    return if (texts.with_indifferent_access.keys - Language.pluck(:code)).empty?

    errors.add(:texts, 'contains invalid language codes')
  end

  def default_text
    # validates the presence of the default langugae text
    return if texts.with_indifferent_access[default_lang].present?

    errors.add(:texts, 'missing the default language translation')
  end

  def personalized?
    kind == 'personalized'
  end

  def construct(user)
    lang_code = user.language.code
    content = texts[lang_code]
    unless content
      incorrect_lang = true
      lang_code = default_lang
      content = texts[lang_code]
    end
    content = content % { user_name: user.first_name } if personalized?
    { content: content, lang_code: lang_code, incorrect_lang: incorrect_lang || false }
  end
end
