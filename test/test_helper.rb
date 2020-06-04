# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def authorization(user_name, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(user_name, password)
  end

  def admin_headers
    { 'HTTP_AUTHORIZATION': authorization('swvl_user', 'MyPass123') }
  end

  def invalid_admin_headers
    { 'HTTP_AUTHORIZATION': authorization('dummy_user', 'none') }
  end
end
