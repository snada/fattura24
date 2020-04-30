# frozen_string_literal: true

RSpec.describe Fattura24::VERSION do
  it 'returns the right version number' do
    expect(Fattura24::VERSION).to eq('1.0.0')
  end
end
