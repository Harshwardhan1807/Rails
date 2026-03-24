class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to notifications_path
  end

  def mark_all_as_read
    current_user.notifications.update_all(read: true)
    redirect_to notifications_path
  end

  def mark_all_as_unread
    current_user.notifications.update_all(read: false)
    redirect_to notifications_path
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, alert: "Notification deleted successfully"
  end
end
