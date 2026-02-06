class User < ApplicationRecord
  has_many :subscriptions
  has_many :channels, through: :subscriptions
  has_many :owned_channels, class_name: "Channel", foreign_key: "owner_id", dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :email_is_valid
  validates :password, length: { minimum: 4 }
  validates :role, presence: true
  validate :check_role
  validates :age, numericality: { greater_than: 5, message: "must be greater than 5" }

  before_save :encrypt_password
  private
    def encrypt_password
      self.password = BCrypt::Password.create(self.password)
    end

    def email_is_valid
      unless email =~ /[^@\s]+@[^@\s]+.[^@\s]+/
      errors.add(:email, "#{email} is not a valid email address")
      end
    end

    def check_role
      if not [ "admin", "viewer", "creator" ].include?(role) and role.present?
        errors.add(:role, "#{role} is not a valid role")
      end
    end
end
