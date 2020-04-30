# frozen_string_literal: true

RSpec.describe Fattura24::Configuration do
  context '#api_key' do
    it 'sets api key as nil when new' do
      expect(Fattura24::Configuration.new.api_key).to be nil
    end

    it 'allows setting api key' do
      c = Fattura24::Configuration.new
      c.api_key = 'apikey'
      expect(c.api_key).to eq 'apikey'
    end
  end
end
