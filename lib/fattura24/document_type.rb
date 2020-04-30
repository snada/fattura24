# frozen_string_literal: true

module Fattura24
  ##
  # This module contains constants to be used
  # when creating documents/credits.

  module DocumentType
    ELECTRONIC_INVOICE = 'FE'
    INVOICE = 'I'
    RECEIPT = 'R'
    CLIENT_ORDER = 'C'
    CREDIT_NOTE = 'N'
  end
end
