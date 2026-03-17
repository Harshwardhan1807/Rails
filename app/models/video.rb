class Video < ApplicationRecord
  has_one_attached :video_file

  belongs_to :channel
  validates :title, :description, presence: true, uniqueness: true
  validates :duration, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :video_file, attached: true, content_type: ["video/mp4"]
end
