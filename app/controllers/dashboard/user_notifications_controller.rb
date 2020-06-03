# frozen_string_literal: true

class Dashboard::UserNotificationsController < ApplicationController
  def create
    notification = Notification.find_by(id: user_notification_params[:notification_id])
    if notification
      CreateNotificationsJob.perform_later(notification: notification, user_ids: user_notification_params[:user_ids])
      render json: success_msg, status: :created
    else
      render json: invalid_notification_msg, status: :unprocessable_entity
    end
  end

  private

  def user_notification_params
    params.require(:user_notification).permit(:notification_id, user_ids: [])
  end

  def success_msg
    { message: 'Sending notifications to users...' }
  end

  def invalid_notification_msg
    {
      notification: [
        'must exist'
      ]
    }
  end
end
