class Reservation < ApplicationRecord
  belongs_to :screening
  has_many :tickets
  validates :status, presence: true
  validates :status, inclusion: { in: %w[Booked Cancelled Accepted] }
end
