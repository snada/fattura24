# frozen_string_literal: true

module Fattura24
  module Api
    ##
    # An instance of this class will be returned on every
    # api call, wrapping the content of the response and
    # providing helper methods to navigate it's content.
    class Response
      ##
      # When needed, you can directly access the underlying
      # {Net::HTTP}[https://ruby-doc.org/stdlib-2.7.0/libdoc/net/http/rdoc/Net/HTTP.html] response
      # by calling this method.
      attr_reader :http_response

      def initialize(http_response)
        @http_response = http_response
      end

      ##
      # Returns +true+ when the http response
      # is 200, +false+ otherwise.
      def success?
        code == 200
      end

      ##
      # Returns the +Integer+ value of the underlying http request.
      # It does not mean the request performed it's intended purpose.
      # Make sure you use {to_s}[rdoc-ref:to_s] or {to_h}[rdoc-ref:to_h]
      # to explore the actual body of the response.
      def code
        http_response&.code.to_i
      end

      ##
      # Returns +true+ when the body of the request contains a pdf file.
      def pdf?
        http_response&.content_type&.underscore == 'application/pdf'
      end

      ##
      # Returns an hash representation of the xml body of the response.
      # Raises {NotSerializable}[rdoc-ref:Fattura24::NotSerializable]
      # in case of a binary (pdf file) content.
      def to_h
        if pdf?
          raise(
            Fattura24::NotSerializable,
            'Cannot create hash from binary file'
          )
        end

        Hash.from_xml(http_response&.body)
          &.deep_transform_keys do |key|
            key.to_s.underscore.to_sym
          end
      end

      ##
      # Returns the +String+ body of this response.
      # This can be both the original xml on most of the calls
      # or the content of the pdf file when {get_file}[rdoc-ref:get_file]
      # is called.
      def to_s
        http_response&.body.to_s
      end
    end
  end
end
