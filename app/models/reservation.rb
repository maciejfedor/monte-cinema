class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user, optional: true
  has_many :tickets, dependent: :destroy
  validates :status, presence: true
  enum :status, { booked: 0, cancelled: 1, accepted: 2 }
  validate :validate_reservation, :validate_deadline,  on: :create

  def validate_reservation
    errors.add(:base, message: 'Choose at least one seat') if seats.compact_blank.blank?
    errors.add(:base, message: 'Seat(s) taken') if !seats.compact_blank.blank? && seat_taken?(screening, seats)
  end

  def validate_deadline
    if !seats.compact_blank.blank? && screening.deadline
      errors.add(:base, message: 'Movie started, cannot make a reservation')
    end
  end

  def seat_taken?(screening, seats)
    seats.each do |seat|
      return true unless screening.available_seats.include? seat
    end
    false
  end

  def seats
    tickets.map(&:seat)
  end
end
