class ReservationsController < ApplicationController
  include Pundit::Authorization
  before_action :set_screening, only: %i[new create]
  before_action :set_reservation, only: %i[show update destroy]
  before_action :authenticate_user!
  def new
    authorize Reservation
    @reservation = Reservation.new
  end

  def create
    @reservation = @screening.reservations.new(status: :booked, user_id: current_user.id)
    authorize @reservation
    Reservation.transaction do
      @reservation.save!
      create_tickets

    rescue StandardError
      render :new, status: :unprocessable_entity and return
    end

    redirect_to screening_reservation_path(@screening, @reservation)
  end

  def update
    authorize Reservation
    @reservation.update(status: params[:status])
    redirect_to screening_reservation_path(params[:screening_id], @reservation)
  end

  def destroy
    authorize @reservation
    @reservation.update(status: :cancelled)
    redirect_to screening_reservation_path(params[:screening_id], @reservation)
  end

  def show
    authorize Reservation
  end

  def index
    @reservations = current_user.reservations
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  def create_tickets
    params[:seats].each do |seat|
      @reservation.tickets.create(seat:)
    end
  end
end
