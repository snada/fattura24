# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#test_key' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/TestKey' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      it 'returns error' do
        expect(Fattura24::Api.test_key.to_h).to eq(
          invalid_api_key_response
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
            description: 'Complimenti, la tua API KEY &egrave; corretta.',
            return_code: '1',
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
