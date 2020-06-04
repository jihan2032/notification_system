# frozen_string_literal: true

class DashboardController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: 'swvl_user', password: 'MyPass123'
end
