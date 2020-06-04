# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  def language
    languages(:en)
  end

  test 'valid language' do
    assert language.valid?
  end

  test 'name uniqueness' do
    l1 = language
    l2 = languages(:ar)
    l1.name = l2.name
    assert_not l1.valid?
  end

  test 'code uniqueness' do
    l1 = language
    l2 = languages(:ar)
    l1.code = l2.code
    assert_not l1.valid?
  end

  test 'name presence' do
    l1 = language
    l1.name = nil
    assert_not l1.valid?
  end

  test 'code presence' do
    l1 = language
    l1.code = nil
    assert_not l1.valid?
  end
end
