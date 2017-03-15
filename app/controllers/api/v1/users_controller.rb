module Api
  module V1
    class UsersController < Api::ApiController
      before_action :authenticate
      before_action :check_password_email, only: [:update]

      include UserDoc

      json_api_methods :index, :show, :update
      json_api_target_class User
      json_api_serializer UserSerializer
      json_api_updateable_params :password, :email, :has_notifications
      json_api_custom_methods :notifications
      json_api_custom_services do
        {
          notifications: { service: UserNotificationsService, current_user: true }
        }
      end
      json_api_custom_serializers do
        {
          notifications: NotificationSerializer
        }
      end

      private

      def check_password_email
        user = User.find(params[:id])
        if params[:password].present? && params[:email].present?
          check_email(user)
        elsif params[:password].present?
          check_password(user)
        end
      end

      def check_password(user)
        raise Errors::NotFound, 'Invalid current password' unless user.valid_password? params[:old_password]
      end

      def check_email(user)
        raise Errors::NotFound, 'Invalid current email address' unless user.email == params[:old_email]
        raise Errors::NotFound, 'Invalid current password' unless (user.valid_password? params[:old_password]) ||
                                                                  (user.valid_password? params[:password])
      end
    end
  end
end
