class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation

  def initialize(user, reservation)
    @user = user
    @reservation = reservation
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    manager_or_admin? || reservation.user_id == user.id
  end

  def update?
    manager_or_admin?
  end

  def destroy?
    manager_or_admin? || reservation.user_id == user.id
  end

  private

  def manager_or_admin?
    user.manager? || user.admin?
  end
end
