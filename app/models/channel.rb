class Channel < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  validates :name, :description, presence: true, uniqueness: true

  before_save :format_name

  def format_name
    self.name = name.titleize
  end
end
