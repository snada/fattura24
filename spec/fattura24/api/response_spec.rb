# frozen_string_literal: true

RSpec.describe Fattura24::Api::Response do
  let(:xml) do
    <<~XML
      <root><returnCode>1</returnCode><description>A description</description></root>
    XML
  end

  let(:valid_url) { 'https://www.app.fattura24.com/api/v0.3/Valid' }
  let(:invalid_url) { 'https://www.app.fattura24.com/api/v0.3/Invalid' }

  let(:valid_response) { Fattura24::Api.request('/Valid') }
  let(:invalid_response) { Fattura24::Api.request('/Invalid') }
  let(:nil_response) { Fattura24::Api::Response.new(nil) }

  before(:each) do
    Fattura24.configure do |c|
      c.api_key = 'whatever'
    end

    stub_request(:post, valid_url)
      .to_return(status: 200, body: xml, headers: {})

    stub_request(:post, invalid_url)
      .to_return(status: 400, body: xml, headers: {})
  end

  describe '#http_response' do
    it 'is set to the raw ok http response' do
      expect(valid_response.http_response).to be_a(Net::HTTPOK)
    end

    it 'is set to the raw ok http response' do
      expect(invalid_response.http_response).to be_a(Net::HTTPBadRequest)
    end
  end

  describe '#success?' do
    it 'returns true on 200 responses' do
      expect(valid_response.success?).to be true
    end

    it 'returns false on other responses' do
      expect(invalid_response.success?).to be false
    end

    it 'returns false on a nil response' do
      expect(nil_response.success?).to be false
    end
  end

  describe '#code' do
    it 'returns true on 200 responses' do
      expect(valid_response.code).to be 200
    end

    it 'returns false on other responses' do
      expect(invalid_response.code).to be 400
    end

    it 'returns 0 on a nil response' do
      expect(nil_response.code).to be 0
    end
  end

  describe '#to_h' do
    it 'returns an hash from the xml body' do
      expect(valid_response.to_h).to eq(
        root: {
          returnCode: '1',
          description: 'A description'
        }
      )
    end

    it 'returns an empty hash on a nil response' do
      expect(nil_response.to_h).to eq({})
    end
  end

  describe '#to_s' do
    it 'returns the raw body of the response' do
      expect(valid_response.to_s).to eq xml
    end

    it 'returns an empty string on a nil response' do
      expect(nil_response.to_s).to eq ''
    end
  end
end
