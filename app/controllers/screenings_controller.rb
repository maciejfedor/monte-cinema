class ScreeningsController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!, except: %i[show index]
  def show
    set_screening
    authorize @screening
  end

  def index
    authorize Screening
    render :index, locals: { movies: Movie.includes(:screenings) }
  end

  def new
    authorize Screening
    @screening = Screening.new
  end

  def edit
    set_screening
    authorize @screening
  end

  def create
    @screening = Screening.new(screening_params)
    authorize @screening
    if @screening.save
      redirect_to screenings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_screening
    authorize @screening
    if @screening.update(screening_params)
      redirect_to screenings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_screening
    authorize @screening
    @screening.destroy
    redirect_to screenings_path
  end

  def screening_params
    params.require(:screening).permit(:hall_id, :movie_id, :start_time)
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end
end
