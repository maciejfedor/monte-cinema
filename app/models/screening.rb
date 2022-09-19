class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :start_time, :end_time, presence: true

  validates :end_time, comparison: { greater_than: :start_time }

  def available_seats
    taken_seats = []
    reservations.each do |r|
      r.tickets.each do |t|
        taken_seats.push(t.seat)
      end
    end
    hall.seats_array - taken_seats
  end
end
