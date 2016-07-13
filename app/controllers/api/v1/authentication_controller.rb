module Api::V1
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
  end
end
