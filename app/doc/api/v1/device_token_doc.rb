module Api
  module V1
    module DeviceTokenDoc
      extend Api::V1::BaseDoc

      doc_for :create do
        api :POST, '/v1/device_tokens', 'Create a device token'
        auth_needed
        internal_error
        param :device_token, String, required: true
        param :operating_system, Integer, required: true, desc: 'The operating system of the device. 0 for iOS, 1 for Android'
      end
    end
  end
end
