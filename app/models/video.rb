class Video < ApplicationRecord
  belongs_to :channel
  validates :title, :description, presence: true, uniqueness: true
  validates :duration, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :video_url, presence: true, uniqueness: true, format: { with: /\Ahttps?:\/\/.+\z/, message: "must be a valid URL" }
end
