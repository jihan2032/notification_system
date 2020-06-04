# frozen_string_literal: true

class Dashboard::NotificationsController < DashboardController
  def create
    notification = Notification.new notification_params
    if notification.save
      render json: notification, status: :created
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end
  end

  def index
    render json: Notification.list.limit(params[:per]), status: :ok
  end

  private

  def notification_params
    params.require(:notification).permit(:provider_id, :default_lang, :kind, texts: {})
  end
end
