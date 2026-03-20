class Video < ApplicationRecord
  has_one_attached :video_file

  belongs_to :channel
  validates :title, :description, presence: true, uniqueness: true
  validates :duration, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :video_file, attached: true, content_type: ["video/mp4"]
  validate :video_file_presence
  after_create :notify_subscribers

  private

  def video_file_presence
    unless video_file.attached?
      errors.add(:video_file, "must be attached")
    end
  end

  def notify_subscribers
    channel.users.each do |user|
      Notification.create(
        user: user,
        message: "New video uploaded to #{channel.name}: #{title}",
        read: false,
      )
    end
  end
end
