module Api
  module V1
    class AuthenticationController < BaseController
      def sign_in
        return_response do
          SignInUserService.new(params).sign_in
        end
      end

      def sign_up
        return_response do
          SignUpUserService.new(params).sign_up
        end
      end

      def forgot_password
        return_response do
          ForgotPasswordService.new(params).forgot_password
        end
      end
    end
  end
end
