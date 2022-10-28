class Screening < ApplicationRecord
  acts_as_paranoid
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates :end_time, comparison: { greater_than: :start_time }, presence: true
  validates :start_time, comparison: { greater_than: Time.current }, presence: true
  before_validation :calculate_end_time

  def movie
    Movie.with_deleted.find(movie_id)
  end

  def available_seats
    taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - taken_seats.flatten
  end

  def calculate_end_time
    self.end_time = start_time + ADS_DURATION + movie.duration.minutes if start_time.present?
  end

  after_destroy do
    CancelAllReservationsJob.perform_later(id)
  end
end
