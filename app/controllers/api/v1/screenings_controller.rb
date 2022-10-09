module Api
  module V1
    class ScreeningsController < ApiController
      before_action :authenticate_user!

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
