class VideoPolicy < ApplicationPolicy
  def update?
    user.present? && (record.channel.owner == user || user.admin?)
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end
end
