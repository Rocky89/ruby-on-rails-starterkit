module Api
  module Concerns
    module BaseEndpoint
      extend ActiveSupport::Concern
      include Api::Concerns::Configuration
      include Api::Concerns::Sorting

      included do
        class_attribute :opts
        self.opts = Api::Concerns::Configuration::DEFAULT_ENDPOINT_OPTIONS.dup
      end

      class_methods do
        def inherited(subclass)
          super
          subclass.opts = Api::Concerns::Configuration::DEFAULT_ENDPOINT_OPTIONS.dup
        end

        private

        def define_custom(method_name)
          define_method(method_name) do
            authorize_target_class(method_name)
            data_to_render = load_custom_date(method_name, current_user, params)
            data_to_render.serializer_detail = :full_detail if [:update].include?(method_name)
            render_json_api_response(data_to_render)
          end
        end

        def define_index
          define_method(:index) do
            authorize_target_class(:index)
            data_to_render = load_read_data(opts)
            data_to_render = data_to_render.order(json_api_sort_options).page(page).per(per_page)
            render_json_api_response(data_to_render)
          end
        end

        def define_show
          define_method(:show) do
            authorize_target_class(:show)
            data_to_render = load_read_data(opts)
            data_to_render = data_to_render.find(params[:id])
            data_to_render.serializer_detail = :full_detail
            render_json_api_response(data_to_render)
          end
        end

        def define_create
          define_method(:create) do
            authorize_target_class(:create)
            data_to_render = opts[:target_class].create(permited_params)
            raise Errors::UnprocessableEntity, data_to_render.errors.full_messages.to_sentence \
              unless data_to_render.valid?
            data_to_render.reload
            render_full_detail(data_to_render)
          end
        end

        def define_update
          define_method(:update) do
            authorize_target_class(:update)
            data_to_render = opts[:target_class].where(json_api_select_filters).find(params[:id])
            raise Errors::NotFound unless data_to_render.present?
            raise Errors::UnprocessableEntity, data_to_render.errors.full_messages.to_sentence \
              unless data_to_render.update(permited_params)
            data_to_render.reload
            render_full_detail(data_to_render)
          end
        end

        def define_destroy
          define_method(:destroy) do
            authorize_target_class(:destroy)
            data_to_render = opts[:target_class].where(json_api_select_filters).find(params[:id])
            raise Errors::NotFound unless data_to_render.present?
            data_to_render.destroy
            render plain: '', status: 204
          end
        end
      end

      def current_user?(method_name)
        json_api_run_services[method_name][:current_user] == true
      end

      def params?(method_name)
        json_api_run_services[method_name][:params] == true
      end

      def render_json_api_response(data_to_render)
        custom_serializer_adapter = load_custom_serializer[:adapter]
        render json_api_serializer_options_for(data_to_render)
          .merge(include: json_api_serializer_include, json: data_to_render, scope: { current_user: current_user },
                 adapter: custom_serializer_adapter || opts[:serializer_adapter])
      end

      def json_api_serializer_options_for(data_to_render)
        custom_serializer = load_custom_serializer[:serializer]
        return {} if custom_serializer == false
        key_name = data_to_render.respond_to?(:each) ? :each_serializer : :serializer
        { key_name => custom_serializer || opts[:serializer] }
      end

      def permited_params
        params.merge(json_api_select_filters).permit(opts[:updateable_params])
      end

      def authorize_target_class(action)
        target_class = opts[:target_class]
        if target_class.instance_of? Class
          authorize! action, target_class
        else
          authorize! action, target_class.classify.constantize
        end
      end

      def render_full_detail(data_to_render)
        data_to_render.serializer_detail = :full_detail
        render_json_api_response(data_to_render)
      end

      def load_custom_serializer
        json_api_run_serializers[params[:action].to_sym] || {}
      end

      def load_read_data(opts)
        data_to_render = opts[:target_class].where(json_api_select_filters)
        ar_include = opts[:ar_include]
        return data_to_render.includes(ar_include) if ar_include.present?
        data_to_render
      end

      def load_custom_date(method_name, current_user, params)
        data = {}
        data[:current_user] = current_user if current_user?(method_name)
        data[:params] = params if params?(method_name)
        json_api_run_services[method_name][:service].new(data).run
      end
    end
  end
end
