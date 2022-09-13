class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    errors.add(:end_time, 'cannot be before start time') if start_time > end_time
  end
end
