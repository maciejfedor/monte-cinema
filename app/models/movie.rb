class Movie < ApplicationRecord
  acts_as_paranoid
  has_many :screenings, -> { order(start_time: :asc) }, dependent: :destroy
  validates :title, :duration, presence: true
  validates :duration, numericality: { greater_than: 0 }
  validates :title, length: { maximum: 200 }
  after_validation :assign_poster


  def assign_poster
    self.poster = ApiExternal::MoviesDataController.new.movie_poster(title)
  end 



end
