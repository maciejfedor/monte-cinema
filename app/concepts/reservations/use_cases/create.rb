module Reservations
  module UseCases
    class Create
<<<<<<< HEAD
      attr_reader :screening_id, :user_id, :seats, :status, :errors, :repository
=======
      attr_reader :screening_id, :user_id, :seats, :status, :repository
>>>>>>> 2f98bde (add create use case)

      def initialize(screening_id:, user_id:, seats:, status:, repository: ReservationRepository.new)
        @screening_id = screening_id
        @user_id = user_id
        @repository = repository
        @seats = seats
        @status = status
<<<<<<< HEAD
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
=======
      end

      def call
        return if seats.blank?

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
>>>>>>> 2f98bde (add create use case)
      end
    end
  end
end
