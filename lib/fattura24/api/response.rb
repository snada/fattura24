# frozen_string_literal: true

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
        Hash.from_xml(http_response&.body)
          &.deep_transform_keys do |key|
            key.to_s.underscore.to_sym
          end
      end

      def to_s
        http_response&.body.to_s
      end
    end
  end
end
