class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  before_action :set_reservation, only: %i[show update]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(screening_id: params[:screening_id], status: :booked)

    Reservation.transaction do
      @reservation.save!
      create_tickets
      redirect_to screening_reservation_path(params[:screening_id], @reservation)

    rescue StandardError
      render :new, status: :unprocessable_entity
    end
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
      Ticket.create(reservation_id: @reservation.id, seat:)
    end
  end
end
