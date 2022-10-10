class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :end_time, comparison: { greater_than: :start_time }, presence: true
  validates :start_time, comparison: { greater_than: Time.current }, presence: true
  before_validation :calculate_end_time

  def available_seats
    taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - taken_seats.flatten
  end

  def calculate_end_time
    self.end_time = start_time + ADS_DURATION + movie.duration.minutes if start_time.present?
  end

  def deadline
    Time.current.after?(start_time - 30.minutes)
  end
end
