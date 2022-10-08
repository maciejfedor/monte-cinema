module Api
  module V1
    class ReservationsController < ApiController
      def create
        @reservation = Reservations::UseCases::Create.new(screening_id: params[:screening_id], user_id: current_user.id,
                                                          seats: params[:seats], status: :booked).call
        if @reservation.errors.none?
          render json: ReservationSerializer.new(@reservation)
        else
          render json: @reservation.errors, status: 500
        end
      end

      def show
        @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
        render json: ReservationSerializer.new(@reservation)
      end

      def index
        @reservation = Reservations::UseCases::FindAll.new.call
        render json: ReservationSerializer.new(@reservation, include: [:tickets])
      end
    end
  end
end
