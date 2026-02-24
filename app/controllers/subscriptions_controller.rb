class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @channel = Channel.find(params[:id])
    @subscription = current_user.subscriptions.create(channel: @channel)
    redirect_to @channel, notice: "Subscribed successfully"
  end

  def destroy
    @channel = Channel.find(params[:id])
    @subscription = current_user.subscriptions.find_by(channel: @channel)
    @subscription.destroy if @subscription
    redirect_to @channel, notice: "Unsubscribed successfully"
  end
end
