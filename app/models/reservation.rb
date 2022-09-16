class Reservation < ApplicationRecord
  belongs_to :screening
  has_many :tickets, dependent: :destroy
  validates :status, presence: true
  enum status: { booked: 'booked', confirmed: 'confirmed', canceled: 'canceled' }
end
