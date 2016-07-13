module Errors
  class Base < StandardError
    attr_reader :message

    def initialize(message = "")
      super
      @message = message
    end
  end
end
