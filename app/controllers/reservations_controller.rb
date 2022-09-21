class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  before_action :set_reservation, only: %i[show update]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @screening.reservations.new(status: :booked)

    Reservation.transaction do
      @reservation.save!
      create_tickets

    rescue StandardError
      render :new, status: :unprocessable_entity and return
    end

    redirect_to screening_reservation_path(@screening, @reservation)
  end

  def update
    @reservation.update(status: params[:status])
    redirect_to screening_reservation_path(params[:screening_id], @reservation)
  end

  def show; end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def create_tickets
    params[:seats].each do |seat|
      @reservation.tickets.create(seat:)
    end
  end
end
