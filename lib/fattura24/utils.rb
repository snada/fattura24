# frozen_string_literal: true

module Fattura24
  module Utils
    def self.crush(obj)
      return crush_hash(obj) if obj.is_a?(Hash)

      return crush_array(obj) if obj.is_a?(Array)

      obj
    end

    def self.crush_array(array)
      r = array.map do |obj|
        crush(obj)
      end.compact

      r.empty? ? nil : r
    end

    def self.crush_hash(hash)
      r = hash.each_with_object({}) do |(k, v), h|
        if (crushed_v = crush(v))
          h[k] = crushed_v
        end
      end

      r.empty? ? nil : r
    end
  end
end
