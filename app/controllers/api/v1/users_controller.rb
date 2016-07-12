module Api::V1
  class UsersController < BaseController

    def index
      render json: User.all
    end

  end
end
