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
    end
  end
end
