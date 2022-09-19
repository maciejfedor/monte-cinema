class MoviesController < ApplicationController
  def index
    @movies = Movie.all

    respond_to do |format|
      format.html
      format.json { render json: movies_with_screenings }
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private

  def movies_with_screenings
    Movie.includes(:screenings).map do |movie|
      screenings = movie_screenings(movie.screenings)

      {
        title: movie.title,
        length: movie.length.minutes,
        screenings: screenings.map do |screening|
          {
            start_time: screening.start_time,
            end_time: screening.end_time
          }
        end
      }
    end
  end

  def movie_screenings(screenings)
    screenings.hold_time(params['start_time'], params['end_time'])
  end
end
