# frozen_string_literal: true

require 'fattura24/api/client'
require 'fattura24/api/response'

require 'fattura24/configuration'
require 'fattura24/errors'
require 'fattura24/version'

module Fattura24
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
