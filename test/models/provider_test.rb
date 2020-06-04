# frozen_string_literal: true

require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  def provider
    providers(:sendgrid)
  end

  def simulate_api_requests(provider_obj)
    u1 = users(:shadya)
    u2 = users(:nagat)
    provider_obj.integrate_with_api(content: 'Some content..', user_id: u1.id)
    provider_obj.integrate_with_api(content: 'Some content..', user_id: u2.id)
  end

  test 'valid provider' do
    assert provider.valid?
  end

  test 'name uniqueness' do
    p1 = provider
    p2 = providers(:twilio)
    p1.name = p2.name
    assert_not p1.valid?
  end

  test 'name presence' do
    p1 = provider
    p1.name = nil
    assert_not p1.valid?
  end

  test 'min_limit presence' do
    p1 = provider
    p1.min_limit = nil
    assert_not p1.valid?
  end

  test 'provider_type presence' do
    p1 = provider
    p1.type = nil
    assert_not p1.valid?
  end

  test 'provider_type value inclusion' do
    p1 = provider
    p1.type = 'Dummy value'
    assert_not p1.valid?
  end

  test 'default api-related values' do
    p1 = provider
    assert_not p1.last_sync
    assert_equal p1.last_min_count, 0
  end

  test 'updating api-related values after 1 request' do
    p1 = provider
    u1 = users(:shadya)
    p1.integrate_with_api(content: 'Some content..', user_id: u1.id)
    assert_equal p1.last_min_count, 1
    assert p1.last_sync
  end

  test 'updating api-related values after 2 requests' do
    p1 = provider
    simulate_api_requests(p1)
    assert_equal p1.last_min_count, 2
  end

  test 'validate not calling the api after reaching the api-limit' do
    p1 = provider
    simulate_api_requests(p1)
    p1.integrate_with_api(content: 'Some content..', user_id: users(:shadya).id)
    assert_equal p1.last_min_count, 2
  end
end
