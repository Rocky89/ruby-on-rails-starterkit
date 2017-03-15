module Api
  module Concerns
    module Configuration
      extend ActiveSupport::Concern

      DEFAULT_ENDPOINTS = [:index, :show, :create, :update, :destroy].freeze
      DEFAULT_ENDPOINT_OPTIONS = {
        methods: DEFAULT_ENDPOINTS,
        target_class: nil,
        ar_include: nil,
        serializer: nil,
        custom_serializers: -> { {} },
        custom_services: -> { {} },
        updateable_params: [],
        select_filter: -> { {} }
      }.freeze

      class_methods do
        # set the methods of the controller
        def json_api_methods(*methods)
          opts[:methods] = methods
          methods.each do |endpoint|
            DEFAULT_ENDPOINTS.include?(endpoint) ? send("define_#{endpoint}") : define_custom(endpoint)
          end
        end

        # set the custom methods of the controller
        def json_api_custom_methods(*custom_methods)
          opts[:custom_methods] = custom_methods
          custom_methods.each do |method_name|
            define_method(method_name) do
              if opts[:target_class].instance_of? Class
                authorize! method_name, opts[:target_class]
              else
                authorize! method_name, opts[:target_class].klass
              end
              service = json_api_run_services[method_name][:service]
              data_to_render = if json_api_run_services[method_name][:params] == true && json_api_run_services[method_name][:current_user] == true
                                 service.new(current_user, params).run
                               elsif json_api_run_services[method_name][:params] == true
                                 service.new(params).run
                               elsif json_api_run_services[method_name][:current_user] == true
                                 service.new(current_user).run
                               else
                                 service.new.run
                               end
              render_json_api_response(data_to_render)
            end
          end
        end

        # set the base class
        def json_api_target_class(klass)
          opts[:target_class] = klass
        end

        # set the serializers for each method
        def json_api_serializer(serializer)
          opts[:serializer] = serializer
        end

        # set the serializer adapter for each method
        def json_api_serializer_adapter(serializer_adapter)
          opts[:serializer_adapter] = serializer_adapter
        end

        # set custom serializers for each controller
        def json_api_custom_serializers(&custom_serializers)
          opts[:custom_serializers] = custom_serializers
        end

        # set custom services for each controller
        def json_api_custom_services(&custom_services)
          opts[:custom_services] = custom_services
        end

        # set the permited params
        def json_api_updateable_params(*updateable_params)
          opts[:updateable_params] = updateable_params
        end

        # set the includes in order to load all the data faster
        def json_api_active_record_include(ar_includes)
          opts[:ar_include] = ar_includes
        end

        # set the default filter value in case of dependency
        def json_api_filter(&block)
          opts[:select_filter] = block
        end
      end

      def json_api_run_serializers
        instance_exec(&opts[:custom_serializers])
      end

      def json_api_run_services
        instance_exec(&opts[:custom_services])
      end

      def json_api_select_filters
        instance_exec(&opts[:select_filter])
      end

      def json_api_serializer_include
        serializer_include = opts[:serializer_include]
        instance_exec(&serializer_include)
      rescue
        serializer_include
      end
    end
  end
end
