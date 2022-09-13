class ScreeningsController < ApplicationController
  def show
    @screening = Screening.find(params[:id])
  end
end

