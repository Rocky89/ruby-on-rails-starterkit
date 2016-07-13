module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate
      load_and_authorize_resource

      def index
        return_response do
          User.all
        end
      end

      def show
        return_response do
          @user
        end
      end
    end
  end
end
