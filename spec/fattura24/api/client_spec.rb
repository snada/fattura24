# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#request' do
    context 'without api key' do
      it 'raises right exception' do
        expect { Fattura24::Api.request('whatever', {}) }
          .to raise_error(Fattura24::MissingApiKey)
      end

      it 'returns a descriptive method' do
        expect { Fattura24::Api.request('whatever', {}) }
          .to raise_error('You need to configure your api key before calling any endpoint')
      end
    end
  end

  describe '#test_key' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/TestKey' }

    context 'with an invalid api key' do
      let(:xml) do
        <<~XML
          <root><returnCode>-1</returnCode><description>You are not authorized to use this service. For more details write to assistenza@fattura24.com</description></root>
        XML
      end

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'invalid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'invalid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns error' do
        expect(Fattura24::Api.test_key.to_h).to eq(
          root: {
            returnCode: '-1',
            description: 'You are not authorized to use this service. For more details write to assistenza@fattura24.com'
          }
        )
      end
    end

    context 'with a valid api key' do
      let(:xml) do
        <<~XML
          <root><returnCode>1</returnCode><subscription><type>5</type><expire>21/04/2021</expire></subscription><description>Complimenti, la tua API KEY &egrave; corretta.</description></root>
        XML
      end

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.test_key.to_h).to eq(
          root: {
            description: 'Complimenti, la tua API KEY è corretta.',
            returnCode: '1',
            subscription: {
              expire: '21/04/2021',
              type: '5'
            }
          }
        )
      end
    end
  end
end
