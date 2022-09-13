class Hall < ApplicationRecord
  has_many :screenings
  validates_associated :screenings
  validates :capacity, numericality: true
  validates :capacity, numericality: {only_integer: true}
  validates :number, :capacity, presence: true
  validates :number, uniqueness: true
 
end
