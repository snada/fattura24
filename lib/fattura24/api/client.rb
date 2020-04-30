# frozen_string_literal: true

require 'net/http'

module Fattura24
  module Api
    ##
    # This library uses {fattura24.com}[https://fattura24.com] v0.3 apis.
    # Check their docs {here}[https://www.fattura24.com/api-documentazione/].
    API_HOST = 'https://www.app.fattura24.com/api/v0.3'

    ##
    # Performs a generic request on the api endpoint using Ruby's
    # {Net::HTTP}[https://ruby-doc.org/stdlib-2.7.0/libdoc/net/http/rdoc/Net/HTTP.html].
    # All the other api methods call this one.
    # Parameter +path+ should always be prepended with '/'.
    # Body will default to an empty hash.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
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

    ##
    # Tests validity of your api key.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.test_key
      request('/TestKey')
    end

    # rubocop:disable Naming/AccessorMethodName

    ##
    # Gets a list of document templates.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.get_template
      request('/GetTemplate')
    end

    ##
    # Gets 'piano dei conti'
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.get_pdc
      request('/GetPdc')
    end

    ##
    # Gets numerator list.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.get_numerator
      request('/GetNumerator')
    end

    ##
    # Donwloads a pdf file for an existing document.
    # Requires an existing document id, throws
    # {MissingInput}[rdoc-ref:Fattura24::MissingInput] when passing a nil +id+.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object: refer
    # to it's documentation to detect a binary file and instruction
    # to save it to disk.
    def self.get_file(id)
      raise(Fattura24::MissingInput, 'You need to provide an id') unless id

      request('/GetFile', { docId: id })
    end

    ##
    # Gets a list of products.
    # You can pass a Hash containing a +code+ or +category+
    # to filter your existing products by them.
    # Throws a
    # {InvalidParams}[rdoc-ref:Fattura24::InvalidParams] when passing
    # an hash containing unrecognized options.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.get_product(options = {})
      validate_params(options, %i[code category])
      request('/GetProduct', options)
    end

    # rubocop:enable Naming/AccessorMethodName

    ##
    # Saves a customer in your contact list.
    # Any +nil+ parameter will be deeply removed
    # by using the {crush}[rdoc-ref:Fattura24::Utils.crush] utility.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.save_customer(data = {})
      request('/SaveCustomer', {
        xml: hash_to_xml(data)
      })
    end

    ##
    # Use this to create documents. Pass a hash with the data, check
    # the README file for examples. Use
    # {DocumentType}[rdoc-ref:Fattura24::DocumentType]
    # enums to specify document type.
    # Any +nil+ parameter will be deeply removed
    # by using the {crush}[rdoc-ref:Fattura24::Utils.crush] utility.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.save_document(data = {})
      request('/SaveDocument', {
        xml: hash_to_xml(data)
      })
    end

    ##
    # Creates a credit.
    # Any +nil+ parameter will be deeply removed
    # by using the {crush}[rdoc-ref:Fattura24::Utils.crush] utility.
    # Returns a {Response}[rdoc-ref:Fattura24::Api::Response] object.
    def self.save_item(data = {})
      request('/SaveItem', {
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

    def self.validate_params(params, permitted_params)
      invalid_params = params.keys.map(&:to_sym) - permitted_params

      raise_params_error(invalid_params) if invalid_params.any?
    end

    def self.raise_params_error(invalid_params)
      msg = "This params are not permitted: #{invalid_params.join(', ')}"
      raise Fattura24::InvalidParams, msg
    end

    private_class_method(
      :hash_to_xml,
      :inject_api_key,
      :validate_params,
      :raise_params_error
    )
  end
end
