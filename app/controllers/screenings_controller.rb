class ScreeningsController < ApplicationController
  def show
    @screening = Screening.find(params[:id])
  end

  def index
    render :index, locals: { movies: Movie.includes(:screenings) }
  end

  def new
    render :new, locals: { screening: Screening.new }
  end
end
