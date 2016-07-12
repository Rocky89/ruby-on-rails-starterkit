module Api::V1
  class BaseController < ActionController::API
    include ActionController::Serialization
    # Generic API stuff here

    rescue_from Exception do |exception|
      render json: { message: exception.message }, status: :internal_server_error  # 500
    end

    def return_response
      begin
        result, status = yield, :ok # 200
      rescue KeyError => error
        result, status = error.message, :bad_request # 400
      rescue SecurityError => error
        result, status = error.message, :unauthorized # 401
      rescue NotFound => error
        result, status = error.message, :not_found # 404
      rescue InvalidData => error
        result, status = error.message, :unprocessable_entity # 422
      end

      render json: result, status: status
    end

  end
end
