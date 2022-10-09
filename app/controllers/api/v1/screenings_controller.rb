module Api
  module V1
    class ScreeningsController < ApiController

      def show
        @screening = Screening.find(params[:id])
        render json: ScreeningSerializer.new(@screening, include: %i[movie hall], fields: {
                                               movie: %i[title duration],
                                               hall: [:name]
                                             })
      end
    end
  end
end
