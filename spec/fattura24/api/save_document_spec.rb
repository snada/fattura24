# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#save_document' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/SaveDocument' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      let(:body) do
        { apiKey: 'invalid', xml: '<?xml version="1.0" encoding="UTF-8"?><Fattura24><Document><CustomerName>whatever</CustomerName></Document></Fattura24>' }
      end

      it 'returns error' do
        expect(Fattura24::Api.save_document({ customer_name: 'whatever' }).to_h).to eq(
          invalid_api_key_response
        )
      end
    end

    context 'with a valid api key' do
      include_context 'valid api key'

      let(:xml) do
        <<~XML
          <root><returnCode>0</returnCode><description>Operation completed</description><docId>0000000</docId><docNumber>23-2020</docNumber><docType>3</docType></root>
        XML
      end

      before(:each) do
        stub_request(:post, url)
          .with(body: {
            apiKey: 'valid',
            xml: '<?xml version="1.0" encoding="UTF-8"?><Fattura24><Document><DocumentType>I</DocumentType><CustomerName>John Doe</CustomerName><CustomerFiscalCode>JHNDOE42A26L219Y</CustomerFiscalCode><CustomerAddress>Via Roma 1</CustomerAddress><CustomerCity>Toronto</CustomerCity><CustomerCountry>CA</CustomerCountry><Payments><Payment><Date>2020-04-27</Date><Amount>100</Amount><Paid>true</Paid></Payment></Payments><Rows><Row><Code>001</Code><Description>Required row description</Description><Qty>1</Qty><Price>100</Price></Row></Rows><IdTemplate>65</IdTemplate><SendEmail>true</SendEmail><Object>test</Object><Total>100</Total><TotalWithoutTax>100</TotalWithoutTax><VatAmount>0</VatAmount></Document></Fattura24>'
          })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.save_document(
          document_type: Fattura24::DocumentType::INVOICE,
          customer_name: 'John Doe',
          customer_fiscal_code: 'JHNDOE42A26L219Y',
          customer_address: 'Via Roma 1',
          customer_city: 'Toronto',
          customer_country: 'CA',
          payments: [
            {
              date: '2020-04-27',
              amount: '100',
              paid: 'true'
            }
          ],
          rows: [
            {
              code: '001',
              description: 'Required row description',
              qty: '1',
              price: '100'
            }
          ],
          id_template: '65',
          send_email: 'true',
          object: 'test',
          total: 100,
          total_without_tax: 100,
          vat_amount: 0
        ).to_h).to eq(
          root: {
            return_code: '0',
            description: 'Operation completed',
            doc_id: '0000000',
            doc_number: '23-2020',
            doc_type: '3'
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
          expect(Fattura24::Api.save_document.to_h).to eq(
            root: {
              return_code: '-2',
              description: 'Your XML is wrong. If you want write to technical support: assistenza@fattura24.com'
            }
          )
        end

        it 'fails on empty data' do
          expect(Fattura24::Api.save_document({}).to_h).to eq(
            root: {
              return_code: '-2',
              description: 'Your XML is wrong. If you want write to technical support: assistenza@fattura24.com'
            }
          )
        end

        it 'fails on empty data' do
          expect(Fattura24::Api.save_document([nil]).to_h).to eq(
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
