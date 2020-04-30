# frozen_string_literal: true

RSpec.describe Fattura24 do
  context '#configuraiton' do
    it 'returns an empty configuration object' do
      expect(Fattura24.configuration).to be_a Fattura24::Configuration
    end
  end

  context '#configure' do
    it 'can be used to set api key' do
      expect do
        Fattura24.configure do |configuration|
          configuration.api_key = 'key'
        end
      end.to change { Fattura24.configuration.api_key }.from(nil).to('key')
    end
  end
end
