class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def toggle
    @channel = Channel.find(params[:id])
    subscription = current_user.subscriptions.find_by(channel: @channel)

    if subscription
      subscription.destroy
      notice = "Unsubscribed successfully"
    else
      current_user.subscriptions.create(channel: @channel)
      notice = "Subscribed successfully"
    end

    redirect_to @channel, notice: notice
  end
end
