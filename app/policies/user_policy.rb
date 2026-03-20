class UserPolicy < ApplicationPolicy
  def update?
    user.present? && (record == user || user.admin?)
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end

  def show?
    update?
  end

  def index?
    user.present? && user.admin?
  end
end
