module Api::V1
  class BaseController < ActionController::API
    include ActionController::Serialization
    include CanCan::ControllerAdditions
    # Generic API stuff here

    rescue_from Exception do |exception|
      render json: { message: exception.message }, status: :internal_server_error  # 500
    end

    def return_response
      begin
        result, status = yield, :ok # 200
      rescue Errors::BadRequest => error
        result, status = { message: error.message }, :bad_request # 400
      rescue Errors::Unauthorized => error
        result, status = { message: error.message }, :unauthorized # 401
      rescue Errors::NotFound => error
        result, status = { message: error.message }, :not_found # 404
      rescue Errors::UnprocessableEntity => error
        result, status = { message: error.message }, :unprocessable_entity # 422
      end
      render json: result, status: status
    end

    def authenticate
      @current_user = CurrentUserService.new(request.headers['token']).authenticate
    end
  end
end
