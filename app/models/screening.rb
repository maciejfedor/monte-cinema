class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  validates :start_time, :end_time, presence: true

  validates :end_time, comparison: { greater_than: :start_time }
end
