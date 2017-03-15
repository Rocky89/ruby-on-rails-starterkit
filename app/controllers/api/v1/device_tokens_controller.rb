module Api
  module V1
    class DeviceTokensController < Api::ApiController
      before_action :authenticate
      before_action :populate_user_data, :clean_device_token, only: [:create]

      include DeviceTokenDoc

      json_api_methods :create
      json_api_updateable_params :device_token, :operating_system, :user_id
      json_api_target_class DeviceToken
      json_api_serializer DeviceTokenSerializer

      private

      def clean_device_token
        DeviceToken.where(device_token: params[:device_token], operating_system: params[:operating_system]).destroy_all
      end
    end
  end
end
