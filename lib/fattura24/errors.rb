# frozen_string_literal: true

module Fattura24
  class Error < RuntimeError; end

  ##
  # Thrown when trying to perform any request
  # on the api without a key set in configuration
  class MissingApiKey < Error
    def message
      'You need to configure your api key before calling any endpoint'
    end
  end

  class MissingInput < Error; end

  class NotSerializable < Error; end

  class InvalidParams < Error; end
end
