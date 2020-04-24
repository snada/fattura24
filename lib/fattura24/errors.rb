# frozen_string_literal: true

module Fattura24
  class Error < RuntimeError; end

  class MissingApiKey < Error
    def message
      'You need to configure your api key before calling any endpoint'
    end
  end
end
