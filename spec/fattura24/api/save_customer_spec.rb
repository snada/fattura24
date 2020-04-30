# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#save_customer' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/SaveCustomer' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      let(:body) do
        { apiKey: 'invalid', xml: '<?xml version="1.0" encoding="UTF-8"?><Fattura24><Document><CustomerName>whatever</CustomerName></Document></Fattura24>' }
      end

      it 'returns error' do
        expect(Fattura24::Api.save_customer({ customer_name: 'whatever' }).to_h).to eq(
          invalid_api_key_response
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
          .with(body: {
            apiKey: 'valid',
            xml: '<?xml version="1.0" encoding="UTF-8"?><Fattura24><Document><CustomerName>John Doe</CustomerName><CustomerAddress>Via Po 1</CustomerAddress><CustomerPostcode>10100</CustomerPostcode><CustomerCity>Torino</CustomerCity><CustomerProvince>TO</CustomerProvince><CustomerFiscalCode>MARROS66C44G217W</CustomerFiscalCode><CustomerVatCode>03912377542</CustomerVatCode><CustomerCellPhone>335123456789</CustomerCellPhone><CustomerEmail>email@fake.com</CustomerEmail><FeCustomerPec>pec@fake.com</FeCustomerPec><FeDestinationCode>0000000</FeDestinationCode></Document></Fattura24>'
          })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.save_customer(
          customer_name: 'John Doe',
          customer_address: 'Via Po 1',
          customer_postcode: '10100',
          customer_city: 'Torino',
          customer_province: 'TO',
          customer_country: nil,
          customer_fiscal_code: 'MARROS66C44G217W',
          customer_vat_code: '03912377542',
          customer_cell_phone: '335123456789',
          customer_email: 'email@fake.com',
          fe_customer_pec: 'pec@fake.com',
          fe_destination_code: '0000000'
        ).to_h).to eq(
          root: {
            return_code: '0',
            description: 'Operazione completata con successo',
            id: '0000000',
            customer_name: 'John Doe',
            customer_address: 'Via Po 1',
            customer_postcode: '10100',
            customer_city: 'Torino',
            customer_fiscal_code: 'MARROS66C44G217W',
            customer_vat_code: '03912377542',
            customer_cell_phone: '335123456789',
            customer_email: 'email@fake.com',
            fe_customer_pec: 'pec@fake.com',
            fe_destination_code: '0000000'
          }
        )
      end

      context 'when passing an empty body' do
        let(:xml) do
          <<~XML
            <root><returnCode>-2</returnCode><description>Your XML is wrong. If you want write to technical support: assistenza@fattura24.com</description></root>
          XML
        end

        before(:each) do
          stub_request(:post, url)
            .with(body: {
              apiKey: 'valid',
              xml: '<?xml version="1.0" encoding="UTF-8"?><Fattura24><Document></Document></Fattura24>'
            })
            .to_return(status: 200, body: xml, headers: {})
        end

        it 'fails on empty data' do
          expect(Fattura24::Api.save_customer.to_h).to eq(
            root: {
              return_code: '-2',
              description: 'Your XML is wrong. If you want write to technical support: assistenza@fattura24.com'
            }
          )
        end

        it 'fails on empty data' do
          expect(Fattura24::Api.save_customer({}).to_h).to eq(
            root: {
              return_code: '-2',
              description: 'Your XML is wrong. If you want write to technical support: assistenza@fattura24.com'
            }
          )
        end

        it 'fails on empty data' do
          expect(Fattura24::Api.save_customer([nil]).to_h).to eq(
            root: {
              return_code: '-2',
              description: 'Your XML is wrong. If you want write to technical support: assistenza@fattura24.com'
            }
          )
        end
      end
    end
  end
end
