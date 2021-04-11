# frozen_string_literal: true

CASH = 'MP01'
WIRE_TRANSFER = 'MP05'
CREDIT_CARD = 'MP08'
RIBA = 'MP12'

RSpec.describe Fattura24::FePaymentCode do
  context '#CASH' do
    it 'returns the right value' do
      expect(Fattura24::FePaymentCode::CASH).to eq('MP01')
    end
  end

  context '#WIRE_TRANSFER' do
    it 'returns the right value' do
      expect(Fattura24::FePaymentCode::WIRE_TRANSFER).to eq('MP05')
    end
  end

  context '#CREDIT_CARD' do
    it 'returns the right value' do
      expect(Fattura24::FePaymentCode::CREDIT_CARD).to eq('MP08')
    end
  end

  context '#RIBA' do
    it 'returns the right value' do
      expect(Fattura24::FePaymentCode::RIBA).to eq('MP12')
    end
  end
end
