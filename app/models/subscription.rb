class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  before_create :check_unique_subscription

  private

  def check_unique_subscription
    errors.add(:user, "is already subscribed to this channel") if Subscription.where(user_id: user_id, channel_id: channel_id).exists?
    throw(:abort) unless errors.empty?
  end
end
