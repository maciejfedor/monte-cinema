class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:screening_id])
  end

  def create
    @reservation = Reservation.new(screening_id: params[:screening_id], status: :booked)

    if !params.key?(:seats)
      render :new, status: :unprocessable_entity

    else
      @reservation.save
      params[:seats].each do |seat|
        Ticket.create(reservation_id: @reservation.id, seat:)
      end
      redirect_to movies_path

    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end
end
