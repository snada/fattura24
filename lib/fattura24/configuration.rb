# frozen_string_literal: true

module Fattura24
  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = nil
    end
  end
end
