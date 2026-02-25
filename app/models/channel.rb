class Channel < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :videos, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  validates :name, :description, presence: true, uniqueness: true
  validate :user_role_check
  before_save :format_name

  def format_name
    self.name = name.titleize
  end

  def user_role_check
    return if owner.blank?
    unless owner.role.in?(["creator", "admin"])
      errors.add(:owner_id, "must belong to a creator or admin")
    end
  end
end
