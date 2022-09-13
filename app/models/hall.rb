class Hall < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :capacity, numericality: { only_integer: true, greater_than: 1 }
  validates :number, :capacity, presence: true
  validates :number, uniqueness: true
end
