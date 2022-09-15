class Hall < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :capacity, numericality: { only_integer: true, greater_than: 1 }
  validates :name, :capacity, presence: true
  validates :name, uniqueness: true

  def seats_array
    (1..capacity).to_a
  end
end
