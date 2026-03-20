class ChannelPolicy < ApplicationPolicy
  def update?
    user.present? && (record.owner == user || user.admin?)
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end
end
