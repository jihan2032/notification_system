# frozen_string_literal: true

class Dashboard::UserNotificationsController < ApplicationController
  before_action :validate_user_ids_presence

  def create
    notification = Notification.find_by(id: user_notification_params[:notification_id])
    if notification
      CreateNotificationsJob.perform_later(notification: notification, user_ids: user_notification_params[:user_ids])
      render json: success_msg, status: :created
    else
      render json: missing_param_msg(:notification), status: :unprocessable_entity
    end
  end

  private

  def validate_user_ids_presence
    render json: missing_param_msg(:user_ids), status: :unprocessable_entity unless user_notification_params[:user_ids]&.any?
  end

  def user_notification_params
    params.require(:user_notification).permit(:notification_id, user_ids: [])
  end

  def success_msg
    { message: 'Sending notifications to users...' }
  end

  def missing_param_msg(key)
    {
      key => [
        'must exist'
      ]
    }
  end
end
