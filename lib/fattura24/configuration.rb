# frozen_string_literal: true

module Fattura24
  class Configuration
    ##
    # Set this attribute to your secret
    # api key to interact with the api
    attr_accessor :api_key

    def initialize
      @api_key = nil
    end
  end
end
