# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#save_customer' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/SaveCustomer' }

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
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns error' do
        expect(Fattura24::Api.save_customer({}).to_h).to eq(
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
          <root><returnCode>0</returnCode><description>Operazione completata con successo</description><id>0000000</id><CustomerName><![CDATA[John Doe]]></CustomerName><CustomerCity><![CDATA[Torino]]></CustomerCity><CustomerAddress><![CDATA[Via Po 1]]></CustomerAddress><CustomerPostcode><![CDATA[10100]]></CustomerPostcode><CustomerVatCode><![CDATA[03912377542]]></CustomerVatCode><CustomerFiscalCode><![CDATA[MARROS66C44G217W]]></CustomerFiscalCode><CustomerEmail><![CDATA[email@fake.com]]></CustomerEmail><CustomerCellPhone><![CDATA[335123456789]]></CustomerCellPhone><FeCustomerPec><![CDATA[pec@fake.com]]></FeCustomerPec><FeDestinationCode><![CDATA[0000000]]></FeDestinationCode></root>
        XML
      end

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.save_customer(
          customer_name: 'John Doe',
          customer_address: 'Via Po 1',
          customer_postcode: '10100',
          customer_city: 'Torino',
          CustomerProvince: 'TO',
          customer_country: nil,
          customer_fiscal_code: 'MARROS66C44G217W',
          customer_vat_code: '03912377542',
          customer_cell_phone: '335123456789',
          customer_email: 'email@fake.com',
          fe_customer_pec: 'pec@fake.com',
          fe_destination_code: '0000000'
        ).to_h).to eq(
          root: {
            returnCode: '0',
            description: 'Operazione completata con successo',
            id: '0000000',
            CustomerName: 'John Doe',
            CustomerCity: 'Torino',
            CustomerAddress: 'Via Po 1',
            CustomerPostcode: '10100',
            CustomerVatCode: '03912377542',
            CustomerFiscalCode: 'MARROS66C44G217W',
            CustomerEmail: 'email@fake.com',
            CustomerCellPhone: '335123456789',
            FeCustomerPec: 'pec@fake.com',
            FeDestinationCode: '0000000'
          }
        )
      end
    end
  end
end
