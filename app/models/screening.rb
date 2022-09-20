class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :start_time, :end_time, presence: true

  validates :end_time, comparison: { greater_than: :start_time }

  def available_seats
    taken_seats = []
    reservations.where.not(status: :cancelled).each do |reservation|
      taken_seats << reservation.tickets.pluck(:seat)
    end
    hall.seats - taken_seats.flatten
  end
end
