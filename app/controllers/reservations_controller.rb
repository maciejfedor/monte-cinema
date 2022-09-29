class ReservationsController < ApplicationController
  include Pundit::Authorization
  before_action :set_screening, only: %i[new create create_at_desk]
  before_action :set_reservation, only: %i[update destroy]
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

    redirect_to reservation_path(@reservation)
  end

  def create_at_desk
    @reservation = @screening.reservations.new(status: :accepted)
    authorize @reservation
    Reservation.transaction do
      @reservation.save!
      create_tickets

    rescue StandardError
      render :new, status: :unprocessable_entity and return
    end

    redirect_to reservation_path(@reservation)
  end

  def update
    authorize @reservation
    @reservation.update(status: params[:status])
    redirect_to reservation_path(@reservation)
  end

  def destroy
    authorize @reservation
    @reservation.update(status: :cancelled)
    redirect_to reservation_path(@reservation)
  end

  def show
    @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
    authorize @reservation
  end

  def index
    @reservations = Reservations::UseCases::FindAll.new.call
    @pagy, @reservations = pagy(@reservations.order(created_at: :desc))
  end

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
