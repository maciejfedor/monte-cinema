class Movie < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :title, :length, presence: true
  validates :length, length: {in: 30..240}
end
