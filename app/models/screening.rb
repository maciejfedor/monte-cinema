class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :start_time, :end_time, presence: true

  validates :end_time, comparison: { greater_than: :start_time }

  def available_seats
    taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - taken_seats.flatten
  end
end
