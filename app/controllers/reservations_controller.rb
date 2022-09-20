class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(screening_id: params[:screening_id], status: :booked)

    unless params.key?(:seats)
      @reservation.errors.add(:base, 'Please choose at least one seat')
      render :new, status: :unprocessable_entity and return
    end

    if !(params[:seats] & @reservation.screening.available_seats).empty?
      @reservation.save
      create_tickets
      redirect_to screening_reservation_path(params[:screening_id], @reservation)
    else
      @reservation.errors.add(:base, 'It is already taken')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
end

  private

def set_screening
  @screening = Screening.find(params[:screening_id])
end

def create_tickets
  params[:seats].each do |seat|
    Ticket.create(reservation_id: @reservation.id, seat:)
  end
end
