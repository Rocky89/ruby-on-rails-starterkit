module Api
  module Concerns
    module Paginatable
      extend ActiveSupport::Concern

      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 10

      def page
        params.fetch(:page) { DEFAULT_PAGE }.to_i
      end

      def per_page
        params.fetch(:per_page) { DEFAULT_PER_PAGE }.to_i
      end
    end
  end
end
