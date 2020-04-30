# frozen_string_literal: true

RSpec.shared_context 'invalid api key', shared_context: :metadata do
  let(:xml) do
    <<~XML
      <root><returnCode>-1</returnCode><description>You are not authorized to use this service. For more details write to assistenza@fattura24.com</description></root>
    XML
  end

  let(:invalid_api_key_response) do
    {
      root: {
        return_code: '-1',
        description: 'You are not authorized to use this service. For more details write to assistenza@fattura24.com'
      }
    }
  end

  before(:each) do
    Fattura24.configure do |c|
      c.api_key = 'invalid'
    end
  end
end