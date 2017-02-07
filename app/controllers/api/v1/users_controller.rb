module Api
  module V1
    class UsersController < Api::ApiController
      before_action :authenticate

      include UserDoc

      json_api_methods :index, :show
      json_api_target_class User
      json_api_serializer UserSerializer
    end
  end
end
