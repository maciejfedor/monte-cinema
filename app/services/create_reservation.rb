class CreateReservation
  SeatsNotAvailableError = Class.new(StandardError)

  def initialize(screening_id:, hall_id:, seats:)
    @screening_id = screening_id
    @hall_id = hall_id
    @seats = seats
  end

  def call
    ActiveRecord::Base.transaction do
      raise_error unless seats_available?

      create_reservation.tap do |reservation|
        seats.each do |seat|
          reservation.tickets.create(seat:)
        end
      end
    end
  end

  private

  attr_reader :screening_id, :hall_id, :seats

  def create_reservation
    Reservation.create!(
      screening_id: screening_id,
      status: 'booked'
    )
  end

  def seats_available?
    CheckSeatsAvailability.new(seats: seats, screening_id: screening_id).call
  end

  def error_message
    raise SeatsNotAvailableError, 'Provided seats are not available'
  end
end
