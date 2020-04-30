# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#request' do
    context 'without api key' do
      it 'raises right exception' do
        expect { Fattura24::Api.request('/whatever', {}) }
          .to raise_error(Fattura24::MissingApiKey)
      end

      it 'returns a descriptive method' do
        expect { Fattura24::Api.request('/whatever', {}) }
          .to raise_error('You need to configure your api key before calling any endpoint')
      end
    end
  end
end
