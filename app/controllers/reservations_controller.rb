class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:screening_id])
  end

  def create
    CreateReservation.new(
      screening_id: params[:screening_id],
      hall_id: params[:hall_id],
      seats: params[:seats]
    ).call
  rescue CreateReservation::SeatsNotAvailableError => error
    # error handler
  end
end
