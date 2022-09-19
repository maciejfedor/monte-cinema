class Hall < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :capacity, numericality: { only_integer: true, greater_than: 1 }
  validates :name, :capacity, presence: true
  validates :name, uniqueness: true

  def seats
    arr = (1..capacity).to_a
    arr.map(&:to_s)
  end
end
