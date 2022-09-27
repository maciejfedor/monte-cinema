class MoviesController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!, except: [:show]

  def index
    authorize Movie
    @movies = Movie.includes(:screenings)
  end

  def show
    set_movie
    authorize @movie
  end

  def new
    authorize Movie
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    authorize @movie
    if @movie.save
      redirect_to @movie
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_movie
    authorize @movie
  end

  def update
    set_movie
    authorize @movie
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_movie
    authorize @movie
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :duration, :id)
  end
end
