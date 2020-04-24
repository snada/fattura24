# frozen_string_literal: true

require 'xmlhasher'

module Fattura24
  module Api
    class Response
      attr_reader :http_response

      def initialize(http_response)
        @http_response = http_response
      end

      def success?
        code == 200
      end

      def code
        http_response&.code.to_i
      end

      def to_h
        XmlHasher.parse(http_response&.body || '')
      end

      def to_s
        http_response&.body.to_s
      end
    end
  end
end
