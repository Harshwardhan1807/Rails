class MoviePolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def index?
    user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
end
