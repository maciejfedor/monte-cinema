class Ticket < ApplicationRecord
  belongs_to :reservation
  validates :seat, presence: true
  validate :seat_available?

  def seat_available?
    errors.add(:seats, :seat_taken) unless reservation.screening.available_seats.include? seat
  end
end
