class Channel < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :videos, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  validates :name, :description, presence: true, uniqueness: true

  before_save :format_name
  before_create :user_role_check

  def format_name
    self.name = name.titleize
  end

  def user_role_check
    unless User.find_by(id: owner_id).role.in?(["creator", "admin"])
      errors.add(:owner_id, "must belong to a user with creator or admin role")
      throw :abort
    end
  end
end
