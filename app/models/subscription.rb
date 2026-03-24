class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  before_create :check_unique_subscription
  after_create :notify_channel_owner

  private

  def check_unique_subscription
    errors.add(:user, "is already subscribed to this channel") if Subscription.where(user_id: user_id, channel_id: channel_id).exists?
    throw(:abort) unless errors.empty?
  end

  def notify_channel_owner
    Notification.create(
      user: channel.owner,
      message: "#{user.name} has subscribed to your channel #{channel.name}.",
      read: false,
    )
  end
end
