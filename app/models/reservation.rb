class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user, optional: true
  has_many :tickets, dependent: :destroy
  validates :status, presence: true
  enum :status, { booked: 0, cancelled: 1, accepted: 2 }
  validate :validate_reservation, on: :create

  def validate_reservation
    seats = tickets.map(&:seat)
    errors.add(:base, message: 'Choose at least one seat') if seats.blank?
    errors.add(:base, message: 'Seat(s) taken') if !seats.blank? && seat_taken?(screening, seats)
  end

  def seat_taken?(screening, seats)
    seats.each do |seat|
      return true unless screening.available_seats.include? seat
    end
    false
  end
end
