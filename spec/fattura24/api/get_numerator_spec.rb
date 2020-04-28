# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#get_numerator' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/GetNumerator' }

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
        expect(Fattura24::Api.get_numerator.to_h).to eq(
          root: {
            return_code: '-1',
            description: 'You are not authorized to use this service. For more details write to assistenza@fattura24.com'
          }
        )
      end
    end

    context 'with a valid api key' do
      let(:xml) { File.read('spec/fixtures/numerator.xml') }

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.get_numerator.to_h).to eq(
          root: {
            doc: {
              id: '1',
              des: 'Fattura'
            },
            sezionale: {
              id: '1',
              id_profilo: '0',
              code: '-{YYYY}',
              anteprima: '01-2020',
              cod_export: '',
              doc: {
                id: '1',
                stato: '2'
              },
              doc_1: '2'
            }
          }
        )
      end
    end
  end
end
