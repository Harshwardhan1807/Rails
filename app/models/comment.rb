class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video
  after_create :generate_notifications

  validates :body, presence: true, length: { minimum: 2, maximum: 500 }

  private

  def generate_notifications
    Notification.create(
      user: video.channel.owner,
      message: "#{user.name} commented on your video '#{video.title}': #{body.truncate(50)}",
      read: false,
    )
    Notification.create(
      user: User.admin,
      message: "#{user.name} commented on the video '#{video.title}': #{body.truncate(50)}",
      read: false,
    )
  end
end
