class ScreeningPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def new?
    manager_or_admin?
  end

  def edit?
    manager_or_admin?
  end

  def create?
    manager_or_admin?
  end

  def update?
    manager_or_admin?
  end

  def destroy?
    manager_or_admin?
  end

  private

  def manager_or_admin?
    user.manager? || user.admin?
  end
end
