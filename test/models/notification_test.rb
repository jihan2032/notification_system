# frozen_string_literal: true

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def notification
    notifications(:promo_code)
  end

  test 'valid notification' do
    assert notification.valid?
  end

  test 'default_lang presence' do
    n1 = notification
    n1.default_lang = nil
    assert_not n1.valid?
  end

  test 'texts presence' do
    n1 = notification
    n1.texts = nil
    assert_not n1.valid?
  end

  test 'kind presence' do
    n1 = notification
    n1.kind = nil
    assert_not n1.valid?
  end

  test 'kind value inclusion' do
    n1 = notification
    n1.kind = 'Dummy value'
    assert_not n1.valid?
  end

  test 'invalid language_codes' do
    n1 = notification
    n1.texts = { tr: 'Dummy msg' }
    assert_not n1.valid?
  end

  test 'default lang presence in the texts hash' do
    n1 = notification
    n1.texts.delete(n1.default_lang)
    assert_not n1.valid?
  end

  test 'valid construct method format' do
    n1 = notification
    u1 = users(:shadya)
    not_obj = n1.construct(u1)
    assert_equal not_obj.keys.sort, %i[content incorrect_lang lang_code]
  end

  test 'valid content value' do
    n1 = notification
    u1 = users(:shadya)
    not_obj = n1.construct(u1)
    assert_equal n1.texts[u1.language.code], not_obj[:content]
  end

  test 'valid incorrect_lang value' do
    n1 = notification
    u1 = users(:nagat)
    not_obj = n1.construct(u1)
    assert not_obj[:incorrect_lang]
  end

  test 'valid lang_code value' do
    n1 = notification
    u1 = users(:sabah)
    not_obj = n1.construct(u1)
    assert_not_equal n1.default_lang, not_obj[:lang_code]
    assert_equal u1.language.code, not_obj[:lang_code]
  end

  test 'valid personalization' do
    n1 = notifications(:news)
    u1 = users(:shadya)
    not_obj = n1.construct(u1)
    assert not_obj[:content].include?(u1.first_name)
    assert_not not_obj[:content].include?('%{user_name}')
  end
end
