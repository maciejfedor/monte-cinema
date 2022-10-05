module Reservations
  module UseCases
    class Create
      attr_reader :screening_id, :user_id, :seats, :status, :errors, :repository

      def initialize(screening_id:, user_id:, seats:, status:, repository: ReservationRepository.new)
        @screening_id = screening_id
        @user_id = user_id
        @repository = repository
        @seats = seats
        @status = status
        @errors = []
      end

      def call
        screening
        reservation = Reservation.new(screening:, user_id:, status: :booked)
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
