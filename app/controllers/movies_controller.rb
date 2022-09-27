class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:screenings)
  end

  def show
    set_movie
  end

  def new
    render :new, locals: { movie: Movie.new }
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_movie
  end

  def update
    set_movie
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :duration, :id)
  end
end
