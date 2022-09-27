class Movie < ApplicationRecord
  has_many :screenings
  validates :title, :duration, presence: true
  validates :duration, numericality: { greater_than: 0 }
  validates :title, length: { maximum: 200 }
end
