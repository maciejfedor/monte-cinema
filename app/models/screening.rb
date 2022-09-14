class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  validates :end_time, comparison: { greater_than: :start_time }
end
