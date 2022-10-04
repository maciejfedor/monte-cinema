module Reservations
  module UseCases
    class CreateAtDesk
      attr_reader :screening_id, :seats, :status, :errors, :repository

      def initialize(screening_id:, seats:, status:, repository: ReservationRepository.new)
        @screening_id = screening_id
        @repository = repository
        @seats = seats
        @status = status
        @errors = []
      end

      def call
        validate_seats
        reservation_transaction unless @errors.any?
        self
      end

      def data
        @reservation
      end

      private

      def create_tickets(reservation)
        seats.each do |seat|
          Ticket.create!(seat:, reservation_id: reservation.id)
        end
      end

      def reservation
        @reservation ||= repository.create_reservation!(screening_id:,
                                                        status: :accepted)
      end

      def validate_seats
        SeatsValidator.validate!(screening:, seats:, errors:)
      end

      def screening
        Screening.find(screening_id)
      end

      def reservation_transaction
        ActiveRecord::Base.transaction do
          @reservation = reservation
          create_tickets(@reservation)
        end
      end
    end
  end
end
