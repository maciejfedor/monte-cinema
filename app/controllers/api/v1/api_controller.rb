module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token
      def not_found_error
        render json: { error: 'Record not found' }, status: :not_found
      end
    end
  end
end
