module Api::V1
  class UsersController < BaseController

    def index
      return_response do
        User.all
      end
    end
  end
end
