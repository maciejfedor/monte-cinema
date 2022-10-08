module Api
  module V1
    class ScreeningsController < ApiController
      def index
        @screenings = Screening.all
        render json: ScreeningSerializer.new(@screenings, { include: %i[hall movie] })
      end

      def show
        @screening = Screening.find(params[:id])
        render json: ScreeningSerializer.new(@screening)
      end
    end
  end
end
