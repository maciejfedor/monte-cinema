class Movie < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :title, :length, presence: true
  validates :length, length: { only_integer: true, maximum: 300 }
  validates :title, length: { maximum: 200 }
end
