class ReservationsController < ApplicationController
  include Pundit::Authorization
  before_action :set_screening, only: %i[new create create_at_desk]
  before_action :authenticate_user!
  def new
    authorize Reservation
    @reservation = Reservation.new
  end

  def create
    authorize Reservation
    @reservation = Reservations::UseCases::Create.new(screening_id: params[:screening_id], user_id: current_user.id,
                                                      seats: params[:seats], status: :booked).call
    if @reservation.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to reservation_path(@reservation)
    end
  end

  def create_at_desk
    authorize Reservation
    @reservation = Reservations::UseCases::CreateAtDesk.new(screening_id: params[:screening_id],
                                                            seats: params[:seats], status: :accepted).call
    if @reservation.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to reservation_path(@reservation)
    end
  end

  def update
    @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
    authorize @reservation
    @reservation = Reservations::UseCases::Update.new(id: params[:id], status: params[:status]).call
    redirect_to reservation_path(@reservation)
  end

  def destroy
    @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
    authorize @reservation
    @reservation = Reservations::UseCases::Cancel.new(id: params[:id]).call
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
end
