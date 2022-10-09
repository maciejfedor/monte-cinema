module Api
  module V1
    class ReservationsController < ApiController
      before_action :authenticate_user!

      def create
        @reservation = Reservations::UseCases::Create.new(screening_id: params[:screening_id], user_id: current_user.id,
                                                          seats: params.dig(:reservations, :seats), status: :booked).call
        if @reservation.errors.none?
          render json: ReservationSerializer.new(@reservation, include: %i[user tickets screening.movie screening.hall],
                                                               fields: { user: [:email], tickets: [:seat], screening: %i[start_time movie hall], movie: %i[title duration], hall: [:name] }), status: :created
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end

      def show
        @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
        render json: ReservationSerializer.new(@reservation, include: %i[user tickets screening.movie screening.hall],
                                                             fields: { user: [:email], tickets: [:seat], screening: %i[start_time movie hall], movie: %i[title duration], hall: [:name] })
      end
    end
  end
end
