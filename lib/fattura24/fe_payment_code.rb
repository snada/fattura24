# frozen_string_literal: true

module Fattura24
  ##
  # This module contains constants to be used
  # when specifying payment types of your electronic invoices.

  module FePaymentCode
    CASH = 'MP01'
    WIRE_TRANSFER = 'MP05'
    CREDIT_CARD = 'MP08'
    RIBA = 'MP12'
  end
end
