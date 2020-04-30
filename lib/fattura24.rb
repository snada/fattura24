# frozen_string_literal: true

require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'

require 'fattura24/api/client'
require 'fattura24/api/response'

require 'fattura24/configuration'
require 'fattura24/document_type'
require 'fattura24/errors'
require 'fattura24/utils'
require 'fattura24/version'

module Fattura24
  ##
  # Returns current configuration object
  def self.configuration
    @configuration ||= Configuration.new
  end

  ##
  # Calling this method will yield to a block
  # passing the +configuration+ object as parameter.
  def self.configure
    yield configuration
  end
end
