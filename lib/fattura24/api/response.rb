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

      def pdf?
        http_response&.content_type&.underscore == 'application/pdf'
      end

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

      def to_s
        http_response&.body.to_s
      end
    end
  end
end
