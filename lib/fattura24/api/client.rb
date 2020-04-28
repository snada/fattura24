# frozen_string_literal: true

require 'net/http'

module Fattura24
  module Api
    API_HOST = 'https://www.app.fattura24.com/api/v0.3'

    def self.request(path, body = {})
      raise Fattura24::MissingApiKey unless Fattura24.configuration.api_key

      uri = URI.parse("#{API_HOST}#{path}")
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(inject_api_key(body))

      req_options = { use_ssl: uri.scheme == 'https' }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      Response.new(response)
    end

    def self.test_key
      request('/TestKey')
    end

    # rubocop:disable Naming/AccessorMethodName
    def self.get_template
      request('/GetTemplate')
    end

    def self.get_pdc
      request('/GetPdc')
    end

    def self.get_numerator
      request('/GetNumerator')
    end

    def self.get_file(id)
      raise(Fattura24::MissingInput, 'You need to provide an id') unless id

      request('/GetFile', { docId: id })
    end

    # rubocop:enable Naming/AccessorMethodName

    def self.save_customer(data = {})
      request('/SaveCustomer', {
        xml: hash_to_xml(data)
      })
    end

    def self.save_document(data = {})
      request('/SaveDocument', {
        xml: hash_to_xml(data)
      })
    end

    def self.hash_to_xml(hash)
      { document: Fattura24::Utils.crush(hash) || '' }
        .to_xml(
          root: 'Fattura24',
          indent: 0,
          skip_types: true,
          camelize: true
        )
    end

    def self.inject_api_key(hash)
      hash.merge(apiKey: Fattura24.configuration.api_key)
    end

    private_class_method :hash_to_xml, :inject_api_key
  end
end
