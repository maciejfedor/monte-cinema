class Reservation < ApplicationRecord
  belongs_to :screening
  has_many :tickets
  validates :status, presence: true
  enum status: { booked: 'booked', confirmed: 'confirmed', canceled: 'canceled' }
end
