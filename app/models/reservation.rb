class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user, optional: true
  has_many :tickets, dependent: :destroy
  validates :status, presence: true
  enum :status, { booked: 0, cancelled: 1, accepted: 2 }
end
