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
        validate_seats
        create_reservation unless @errors.any?
        self
      end

      def data
        reservation
      end

      def create_tickets(reservation)
        seats.each do |seat|
          Ticket.create!(seat:, reservation_id: reservation.id)
        end
      end

      def reservation
        @reservation ||= repository.create_reservation!(screening_id:, user_id:,
                                                        status:)
      end

      def validate_seats
        SeatsValidator.validate!(screening:, seats:, errors:)
      end

      def screening
        Screening.find(screening_id)
      end

      def create_reservation
        ActiveRecord::Base.transaction do
          create_tickets(reservation)
        end
      end
    end
  end
end
