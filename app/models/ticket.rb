class Ticket < ApplicationRecord
  belongs_to :reservation
  validates :seat, presence: true
end
