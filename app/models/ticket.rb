class Ticket < ApplicationRecord
  belongs_to :reservation
  validates :seat, presence: true
  validate :seat_available?

  def seat_available?
    raise StandardError, 'Seat taken' unless Reservation.find(reservation_id).screening.available_seats.include? seat
  end
end
