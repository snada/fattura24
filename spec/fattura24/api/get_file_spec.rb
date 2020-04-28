# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#get_file' do
    let(:id) { '001' }
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/GetFile' }

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
          .with(body: { apiKey: 'invalid', docId: id })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns error' do
        expect(Fattura24::Api.get_file(id).to_h).to eq(
          root: {
            return_code: '-1',
            description: 'You are not authorized to use this service. For more details write to assistenza@fattura24.com'
          }
        )
      end
    end

    context 'with a valid api key' do
      let(:file) { File.read('spec/fixtures/mock_invoice.pdf') }

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid', docId: id })
          .to_return(
            status: 200,
            body: file,
            headers: {
              'content-type': 'application/pdf'
            }
          )
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.get_file(id).to_s).to eq(file)
      end
    end
  end
end
