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
        screening
        reservation = Reservation.new(screening:, status: :accepted)
        seats.each { |seat| reservation.tickets.new(seat:) } if seats.present?
        reservation.save
        reservation
      end

      private

      def screening
        Screening.find(screening_id)
      end
    end
  end
end
