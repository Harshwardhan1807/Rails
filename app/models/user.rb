class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions, dependent: :destroy
  has_many :channels, through: :subscriptions
  has_many :owned_channels, class_name: "Channel", foreign_key: "owner_id", dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :email_is_valid
  validates :password, length: { minimum: 4 }
  validates :role, presence: true, inclusion: { in: %w[admin creator viewer], message: "%{value} is not a valid role" }
  validates :age, numericality: { greater_than: 5, message: "must be greater than 5" }
  after_create :generate_welcome_notification

  def email_is_valid
    unless email =~ /[^@\s]+@[^@\s]+.[^@\s]+/
      errors.add(:email, "#{email} is not a valid email address")
    end
  end

  def admin?
    role == "admin"
  end

  def self.admin
    find_by(role: "admin")
  end

  private

  def generate_welcome_notification
    Notification.create(
      user: self,
      message: "Welcome to the streaming platform, #{name}!",
      read: false,
    )
    Notification.create(
      user: User.admin,
      message: "New user signed up: #{name} (#{email})",
      read: false,
    )
  end
end
