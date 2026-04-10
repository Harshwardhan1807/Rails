class Channel < ApplicationRecord
  has_one_attached :photo
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :videos, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  validates :name, :description, presence: true, uniqueness: true
  validates :photo, content_type: ["image/png", "image/jpeg"]
  validate :user_role_check
  before_save :format_name
  after_create :generate_channel_creation_notification

  def format_name
    self.name = name.titleize
  end

  def user_role_check
    return if owner.blank?
    unless owner.role.in?(["creator", "admin"])
      errors.add(:owner_id, "must belong to a creator or admin")
    end
  end

  private

  def generate_channel_creation_notification
    Notification.create(
      user: owner,
      message: "Your channel #{name} has been created successfully.",
      read: false,
    )
    Notification.create(
      user: User.admin,
      message: "A new channel #{name} has been created by #{owner.name}.",
      read: false,
    )
  end
end
