class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def toggle
    @channel = Channel.find(params[:id])
    subscription = current_user.subscriptions.find_by(channel: @channel)

    if subscription
      subscription.destroy
      Notification.create(
        user: @channel.owner,
        message: "#{current_user.name} unsubscribed from #{@channel.name}",
        read: false,
      )
      alert = "Unsubscribed successfully"
    else
      current_user.subscriptions.create(channel: @channel)
      Notification.create(
        user: @channel.owner,
        message: "#{current_user.name} subscribed to #{@channel.name}",
        read: false,
      )
      notice = "Subscribed successfully"
    end

    redirect_to @channel, notice: notice, alert: alert
  end
end
