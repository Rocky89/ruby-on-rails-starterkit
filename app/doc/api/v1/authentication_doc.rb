module Api
  module V1
    module AuthenticationDoc
      extend Api::V1::BaseDoc

      doc_for :sign_in do
        api :POST, '/v1/users/sign_in', 'User sign in'
        param :email, String, required: true
        param :password, String, required: true
        internal_error
        token_and_os_needed
      end

      doc_for :sign_up do
        api :POST, '/v1/users/sign_up', 'User sign up'
        param :email, String, required: true
        param :password, String, required: true
        param :username, String, required: true
        param :name, String
        internal_error
        token_and_os_needed
      end

      doc_for :forgot_password do
        api :POST, '/v1/users/forgot_password', 'User forgot password'
        param :email, String
        internal_error
      end

      doc_for :sign_out do
        api :POST, '/v1/users/sign_out', 'User sign out'
        token_and_os_needed
      end
    end
  end
end
