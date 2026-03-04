class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions, dependent: :destroy
  has_many :channels, through: :subscriptions
  has_many :owned_channels, class_name: "Channel", foreign_key: "owner_id", dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :email_is_valid
  validates :password, length: { minimum: 4 }
  validates :role, presence: true, inclusion: { in: %w[admin creator viewer], message: "%{value} is not a valid role" }
  validates :age, numericality: { greater_than: 5, message: "must be greater than 5" }

  def email_is_valid
    unless email =~ /[^@\s]+@[^@\s]+.[^@\s]+/
      errors.add(:email, "#{email} is not a valid email address")
    end
  end
end
