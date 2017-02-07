module Api
  module V1
    class AuthenticationController < Api::ApiController
      include AuthenticationDoc

      before_action :authorize_method
      before_action :authenticate, only: [:sign_out]

      def sign_in
        device_token, os = load_header_data(request.headers)
        data_to_render = SignInUserService.new(params.merge(device_token: device_token, os: os)).sign_in
        data_to_render.serializer_detail = :full_detail
        render json: data_to_render, adapter: :json
      end

      def sign_up
        device_token, os = load_header_data(request.headers)
        data_to_render = SignUpUserService.new(params.merge(device_token: device_token, os: os)).sign_up
        data_to_render.serializer_detail = :full_detail
        render json: data_to_render, adapter: :json
      end

      def forgot_password
        data_to_render = ForgotPasswordService.new(params).forgot_password
        render json: data_to_render, adapter: :json
      end

      def sign_out
        device_token, os = load_header_data(request.headers)
        data_to_render = SignOutService.new(params.merge(device_token: device_token, os: os), current_user).sign_out
        render json: data_to_render, adapter: :json
      end

      private

      def authorize_method
        authorize! params[:action].to_sym, User
      end

      def load_header_data(headers)
        device_token = headers['device_token']
        os = headers['HTTP_OS']
        [device_token, os]
      end
    end
  end
end
