# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

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

    def self.save_customer(data = {})
      request('/SaveCustomer', {
        apiKey: Fattura24.configuration.api_key,
        xml: hash_to_xml(data)
      })
    end

    def self.hash_to_xml(hash)
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.Fattura24 do
          xml.Document do
            hash.keys.map do |key|
              xml.send(key.to_s.split('_').map(&:capitalize).join, hash[key])
            end
          end
        end
      end.to_xml
    end

    private_class_method :hash_to_xml
  end
end
