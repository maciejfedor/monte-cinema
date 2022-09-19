class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  validates :start_time, :end_time, presence: true

  validates :end_time, comparison: { greater_than: :start_time }

  def self.hold_time(start_time, end_time)
    where('start_time > ?', start_time)
      .where('end_time < ?', end_time)
  end
end
