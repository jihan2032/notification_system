# frozen_string_literal: true

class UserNotificationsController < ApplicationController
  def index
    current_user ||= User.find params[:user_id]
    render json: current_user.notifications.limit(params[:per])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Invalid user_id' }, status: :not_found
  end
end
