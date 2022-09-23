class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:screenings)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
