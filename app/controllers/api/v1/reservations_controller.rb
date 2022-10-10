module Api
  module V1
    class ReservationsController < ApiController
      before_action :authenticate_user!

      def create
        @reservation = Reservations::UseCases::Create.new(screening_id: params[:screening_id], user_id: current_user.id,
                                                          seats: params.dig(:reservations, :seats), status: :booked).call
        if @reservation.errors.none?
          ConfirmationMailJob.perform_later(@reservation.id)
          render json: ReservationSerializer.new(@reservation, include: include_options, fields: fields_options),
                 status: :created
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end

      def show
        @reservation = Reservations::UseCases::Find.new(id: params[:id]).call
        render json: ReservationSerializer.new(@reservation, include: include_options, fields: fields_options)
      end

      def include_options
        %i[user tickets screening.movie screening.hall]
      end

      def fields_options
        { user: [:email], tickets: [:seat], screening: %i[start_time movie hall], movie: %i[title duration],
          hall: [:name] }
      end
    end
  end
end
