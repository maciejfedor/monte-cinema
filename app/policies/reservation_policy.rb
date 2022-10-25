class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation

  def initialize(user, reservation)
    @user = user
    @reservation = reservation
  end

  class Scope < Scope
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    owns_reservation?
  end

  def new?
    true
  end

  def create?
    true
  end

  def create_at_desk?
    manager_or_admin?
  end

  def update?
    manager_or_admin?
  end

  def destroy?
    owns_reservation?
  end


  private

  def manager_or_admin?
    user.manager? || user.admin?
  end

  def owns_reservation?
    manager_or_admin? || reservation.user_id == user.id
  end
end
