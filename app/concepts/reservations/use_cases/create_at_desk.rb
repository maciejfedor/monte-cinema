module Reservations
  module UseCases
    class CreateAtDesk
      attr_reader :screening_id, :seats, :status, :repository

      def initialize(screening_id:, seats:, status:, repository: ReservationRepository.new)
        @screening_id = screening_id
        @repository = repository
        @seats = seats
        @status = status
      end

      def call
        ActiveRecord::Base.transaction do
          reservation
          create_tickets(reservation)
        end
        reservation
      end

      def create_tickets(reservation)
        seats.each do |seat|
          Ticket.create!(seat:, reservation_id: reservation.id)
        end
      end

      def reservation
        @reservation ||= repository.create_reservation!(screening_id:,
                                                        status:)
      end
    end
  end
end
