module Api
  module V1
    module UserDoc
      extend Api::V1::BaseDoc

      doc_for :index do
        api :GET, '/v1/users', 'Display all users'
        auth_needed
        internal_error
        pagination_needed
      end

      doc_for :show do
        api :GET, '/v1/users/:id', 'Show user profile'
        auth_needed
        internal_error
      end

      doc_for :update do
        api :PUT, '/v1/users/:id', 'Update user profile'
        auth_needed
        error code: 500, desc: 'Internal server error'
        param :email, String
        param :password, String
        param :device_token, String
        param :operating_system, Integer
        param :has_notifications, Integer
      end

      doc_for :notifications do
        api :GET, '/v1/users/notifications', 'Returns the user\'s notifications'
        auth_needed
        internal_error
      end
    end
  end
end
