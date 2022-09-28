class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :start_time, :end_time, presence: true
  validates_comparison_of :end_time, greater_than: :start_time
  validates :start_time, comparison: {greater_than: Time.now.in_time_zone('Poland')}
  before_validation :calculate_end_time

  def available_seats
    taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - taken_seats.flatten
  end

  def calculate_end_time
    self.end_time = start_time + ADS_DURATION + movie.duration.minutes if start_time.present?
  end
end
