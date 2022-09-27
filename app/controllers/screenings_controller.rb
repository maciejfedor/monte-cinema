class ScreeningsController < ApplicationController
  def show
    set_screening
  end

  def index
    render :index, locals: { movies: Movie.includes(:screenings) }
  end

  def new
    @screening = Screening.new
  end

  def edit
    set_screening
  end

  def create
    @screening = Screening.new(screening_params)

    if @screening.save
      redirect_to screenings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_screening
    if @screening.update(screening_params)
      redirect_to screenings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def screening_params
    params.require(:screening).permit(:hall_id, :movie_id, :start_time)
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end
end
