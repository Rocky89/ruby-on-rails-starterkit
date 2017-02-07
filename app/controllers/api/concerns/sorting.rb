module Api
  module Concerns
    module Sorting
      extend ActiveSupport::Concern

      JSON_API_SORT_OPERATOR = '-'.freeze
      JSON_API_SORT_SEPERATOR = ','.freeze

      def json_api_sort_options
        mapping_json_api_sort_options do |item|
          item_order(item)
        end
      end

      def mapping_json_api_sort_options
        (params[:sort] || '').split(JSON_API_SORT_SEPERATOR).map do |item|
          yield item
        end.to_h
      end

      private

      def item_order(item)
        if item.start_with?(JSON_API_SORT_OPERATOR)
          [item[1..-1].to_sym, :desc]
        else
          [item.to_sym, :asc]
        end
      end
    end
  end
end
