class Channel < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :videos, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  validates :name, :description, presence: true, uniqueness: true

  before_save :format_name

  def format_name
    self.name = name.titleize
  end
end
