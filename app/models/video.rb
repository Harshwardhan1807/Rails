class Video < ApplicationRecord
  has_one_attached :video_file

  belongs_to :channel
  validates :title, :description, presence: true, uniqueness: true
  validates :duration, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :video_file, attached: true, content_type: ["video/mp4"]
  validate :video_file_presence
  after_create :generate_notifications

  private

  def video_file_presence
    unless video_file.attached?
      errors.add(:video_file, "must be attached")
    end
  end

  def generate_notifications
    channel.users.each do |user|
      Notification.create(
        user: user,
        message: "New video uploaded to #{channel.name}: #{title}",
        read: false,
      )
    end
    Notification.create(
      user: channel.owner,
      message: "Your video '#{title}' has been successfully uploaded to #{channel.name}.",
      read: false,
    )
    Notification.create(
      user: User.admin,
      message: "A new video has been uploaded to #{channel.name}: #{title}",
      read: false,
    )
  end
end
