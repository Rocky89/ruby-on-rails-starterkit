module Api
  module V1
    module BaseDoc
      include Apipie::DSL::Concern

      def namespace(namespace, options = {})
        @namespace = namespace
        @namespace_name = options[:name]
      end

      attr_reader :namespace_name

      def resource(resource)
        apipie_resource_setup(resource)

        resource_description do
          controller_namespace_name = @controller.namespace_name
          api_version controller_namespace_name if controller_namespace_name
        end
      end

      def apipie_resource_setup(resource)
        controller_name = resource.to_s.camelize + 'Controller'

        (class << self; self; end).send(:define_method, :superclass) do
          mod = @namespace.present? ? @namespace.classify.constantize : Object
          mod.const_get(controller_name)
        end

        Apipie.app.set_resource_id(self, controller_name)
      end

      def doc_for(action_name, &block)
        instance_eval(&block)
        api_version namespace_name if namespace_name
        api_version '1'
        define_method(action_name) do
        end
      end

      def auth_needed
        header 'token', '&lt;Your API token&gt;', required: true
        error code: 401, desc: 'User not found or token invalid'
      end

      def token_and_os_needed
        header 'device_token', 'The device token or registration ID if Android', required: false
        header 'os', 'The operating system of the device. 0 for iOS, 1 for Android', required: false
      end

      def device_token_needed
        header 'device_token', 'The device token or registration ID if Android', required: true
      end

      def pagination_needed
        param :page, Integer, required: true
        param :per_page, Integer, required: true
      end

      def internal_error
        error code: 500, desc: 'Internal server error'
        error code: 404, desc: 'Not found'
        error code: 422, desc: 'Unprocessable entity'
      end
    end
  end
end
