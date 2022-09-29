module Reservations
  module UseCases
    class Create
      attr_reader :screening_id, :user_id, :seats, :status, :repository

      def initialize(screening_id:, user_id:, seats:, status:, repository: ReservationRepository.new)
        @screening_id = screening_id
        @user_id = user_id
        @repository = repository
        @seats = seats
        @status = status
      end

      def call
        ActiveRecord::Base.transaction do
          repository.create_reservation(screening_id:, user_id:,
                                        status:).tap do |reservation|
            create_tickets(reservation)
          end
        end
      end

      def create_tickets(reservation)
        seats.each do |seat|
          Ticket.create!(seat:, reservation_id: reservation.id)
        end
      end
    end
  end
end
