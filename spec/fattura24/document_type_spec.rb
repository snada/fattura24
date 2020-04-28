# frozen_string_literal: true

RSpec.describe Fattura24::DocumentType do
  context '#INVOICE' do
    it 'returns the right value' do
      expect(Fattura24::DocumentType::INVOICE).to eq('I')
    end
  end

  context '#RECEIPT' do
    it 'returns the right value' do
      expect(Fattura24::DocumentType::RECEIPT).to eq('R')
    end
  end

  context '#CLIENT_ORDER' do
    it 'returns the right value' do
      expect(Fattura24::DocumentType::CLIENT_ORDER).to eq('C')
    end
  end

  context '#CREDIT_NOTE' do
    it 'returns the right value' do
      expect(Fattura24::DocumentType::CREDIT_NOTE).to eq('N')
    end
  end
end
