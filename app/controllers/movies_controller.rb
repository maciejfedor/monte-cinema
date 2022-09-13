class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @screenings = Screening.all
  end

  def show
    @movie = Movie.find(params[:id])
    @screenings = @movie.screenings
  end
end

