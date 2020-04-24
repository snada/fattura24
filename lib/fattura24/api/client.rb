# frozen_string_literal: true

require 'net/http'

module Fattura24
  module Api
    API_HOST = 'https://www.app.fattura24.com/api/v0.3'

    def self.request(path, body = {})
      raise Fattura24::MissingApiKey unless Fattura24.configuration.api_key

      uri = URI.parse("#{API_HOST}#{path}")
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(body)

      req_options = { use_ssl: uri.scheme == 'https' }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      Response.new(response)
    end

    def self.test_key
      request('/TestKey', { apiKey: Fattura24.configuration.api_key })
    end
  end
end
