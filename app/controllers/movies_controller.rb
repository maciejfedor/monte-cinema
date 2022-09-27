class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:screenings)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    render :new, locals: { movie: Movie.new }
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :length)
  end
end
