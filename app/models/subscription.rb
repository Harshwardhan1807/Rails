class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  before_create :check_unique_subscription
  after_create :generate_subscribe_notifications
  after_destroy :generate_unsubscribe_notifications

  private

  def check_unique_subscription
    errors.add(:user, "is already subscribed to this channel") if Subscription.where(user_id: user_id, channel_id: channel_id).exists?
    throw(:abort) unless errors.empty?
  end

  def generate_subscribe_notifications
    Notification.create(
      user: channel.owner,
      message: "#{user.name} has subscribed to your channel #{channel.name}.",
      read: false,
    )
    Notification.create(
      user: self.user,
      message: "You have successfully subscribed to #{channel.name}.",
      read: false,
    )
  end

  def generate_unsubscribe_notifications
    Notification.create(
      user: channel.owner,
      message: "#{user.name} has unsubscribed from your channel #{channel.name}.",
      read: false,
    )
    Notification.create(
      user: self.user,
      message: "You have successfully unsubscribed from #{channel.name}.",
      read: false,
    )
  end
end
