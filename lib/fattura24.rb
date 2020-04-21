# frozen_string_literal: true

require 'fattura24/configuration'
require 'fattura24/version'

module Fattura24
  # class Error < StandardError; end
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
