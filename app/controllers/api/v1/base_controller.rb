module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::Serialization
      include CanCan::ControllerAdditions
      # Generic API stuff here

      rescue_from Exception do |exception|
        render json: { message: exception.message },
               status: :internal_server_error # 500
      end

      def return_response
        begin
          result = yield
          status = :ok # 200
        rescue Errors::BadRequest, Errors::Unauthorized, Errors::NotFound,
               Errors::UnprocessableEntity => error
          result = { message: error.message }
          status = get_status_code(error.class)
          # byebug
        end
        render json: result, status: status
      end

      def authenticate
        @current_user =
          CurrentUserService.new(request.headers['token']).authenticate
      end

      private

      def get_status_code(type)
        if type == Errors::BadRequest
          :bad_request # 400
        elsif type == Errors::Unauthorized
          :unauthorized # 401
        elsif type == Errors::NotFound
          :not_found # 404
        elsif type == Errors::UnprocessableEntity
          :unprocessable_entity # 422
        end
      end
    end
  end
end
