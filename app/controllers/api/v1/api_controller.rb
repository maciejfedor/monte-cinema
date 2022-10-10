module Api
  module V1
    class ApiController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
      def not_found_error
        render json: { error: 'Record not found' }, status: :not_found
      end
    end
  end
end
