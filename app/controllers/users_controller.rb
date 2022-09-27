class UsersController < ApplicationController
  def show
    @reservations = current_user.reservations
    @pagy, @reservations = pagy(@reservations.order(created_at: :desc))
  end
end
